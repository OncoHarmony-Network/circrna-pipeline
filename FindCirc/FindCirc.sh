#!/usr/bin/env bash
#set -euxo pipefail

source activate FindCirc

# 0. Config 
sample=$1
indir=$2
oudir=$3
ncpu=$4
prefix=${sample}
fasta=/home/data/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa
INDEX=/home/data/reference/hg38_ek12/GRCh38.primary_assembly.bt2
#INDEX=/home/data/reference/hg38_ek12/bowtie2.hg38

#========================================================
outdir2=${oudir}/find_circ
mkdir -p ${outdir2}
cd ${outdir2}

if [ -f ../${prefix}.find_circ.ok ]; then
    echo "Final result file detected, skipping this sample."
    exit 0
fi

echo "Start find_circ for ${sample} at `date`"
echo "1. Aligning reads..."

bowtie2 \
    -x ${INDEX} \
    -q -1 ${indir}/${sample}_1.fastq.gz -2 ${indir}/${sample}_2.fastq.gz \
    --threads ${ncpu} \
    --very-sensitive --score-min=C,-15,0 --reorder --mm \
    2> ${prefix}.bowtie2.log | samtools sort -@ ${ncpu} -o ${prefix}.bam -
samtools index -@ ${ncpu} ${prefix}.bam

echo "2. Fetching the unmapped reads"
samtools view -@ ${ncpu} -hbf 4 ${prefix}.bam > ${prefix}.unmapped.bam
samtools index -@ ${ncpu} ${prefix}.unmapped.bam

echo "3. Splitting into anchors"
unmapped2anchors.py ${prefix}.unmapped.bam > ${prefix}.unmapped.fastq

echo "4. Aligning anchors and piping through find_circ"

bowtie2 -q -U ${prefix}.unmapped.fastq -x ${INDEX} --threads ${ncpu} \
    --reorder --mm --very-sensitive --score-min=C,-15,0 2> ${prefix}.bowtie2.2nd.log | \
    find_circ.py -G ${fasta} -n ${prefix} \
    --stats ${prefix}.sites.log \
    --reads ${prefix}.spliced_reads.fa \
    > ${prefix}.splice_sites.bed

grep CIRCULAR ${prefix}.splice_sites.bed | \
    grep -v chrM | \
    grep UNAMBIGUOUS_BP | grep ANCHOR_UNIQUE | \
    maxlength.py 100000 \
    > ${prefix}.txt

awk -v OFS="\t" '{print $1,$2,$3,$6,$5,$4}' ${prefix}.txt > ../${prefix}.find_circ.bed

# 获取上一个命令的退出状态码
exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo "Done for ${sample}, final result is ${prefix}.find_circ.bed"
    touch ../${prefix}.find_circ.ok
else
    if [ -f ../${prefix}.find_circ.ok ]; then
        rm ../${prefix}.find_circ.ok
    fi
fi

rm *.bam *.bai *.fastq *.fa

echo "End find_circ for ${sample} at `date`"
