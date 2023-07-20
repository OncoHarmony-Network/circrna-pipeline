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

if [ -f ../${prefix}.find_circ.bed ] && [ -s ../${prefix}.find_circ.bed ]; then
    echo "Final result exists and is not empty, skipped this sample."
    exit 0
elif [ -f ../${prefix}.find_circ.bed ]; then
    echo "Final result file exists but is empty, re-run it."
else
    echo "Final result file does not exist, run it."
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

rm *.bam *.bai *.fastq *.fa

echo "Done for ${sample}, final result should be ${prefix}.find_circ.bed"
echo "End find_circ for ${sample} at `date`"
