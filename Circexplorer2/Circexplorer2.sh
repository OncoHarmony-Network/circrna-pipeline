#!/usr/bin/env bash

source activate Circexplorer2

# 0. Config
sample=$1
indir=$2
oudir=$3
ncpu=$4
prefix=${sample}
fasta=/home/data/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa
ann_ref=/home/data/reference/hg38_ek12/hg38_ref_all.txt 

#========================================================
outdir2=${oudir}/circexplorer2
mkdir -p ${outdir2}
cd ${outdir2}

if [ -f ../${prefix}.circexplorer2.ok ]; then
    echo "Final result file detected, skipping this sample."
    exit 0
fi

unmap_bwa_sam=${outdir2}/${prefix}'_unmapped_bwa.sam'

echo "Start circexplorer2 for ${sample} at `date`"
echo "1. Aligning reads..."
# step1
bwa mem -t ${ncpu} -T 19 ${fasta} ${indir}/${sample}_1.fastq.gz ${indir}/${sample}_2.fastq.gz > ${unmap_bwa_sam} 2> ${prefix}'_bwa.log'

echo "2. Running parse module..."
# step2
CIRCexplorer2 parse -t BWA -b ${prefix}'_circ2_result.txt' ${unmap_bwa_sam} > ${prefix}'_parse.log'

echo "3. Running annotate module..."
# step3
CIRCexplorer2 annotate -r ${ann_ref} -g ${fasta} -b ${prefix}'_circ2_result.txt' -o ${prefix}'_circ2_result_ann.txt'

awk -v OFS="\t" '{print $1,$2,$3,$6,$13}' ${prefix}'_circ2_result_ann.txt' > ../${prefix}.circexplorer2.bed

# 获取上一个命令的退出状态码
exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo "Done for ${sample}, final result is ${prefix}.circexplorer2.bed"
    touch ../${prefix}.circexplorer2.ok
else
    if [ -f ../${prefix}.circexplorer2.ok ]; then
        rm ../${prefix}.circexplorer2.ok
    fi
fi

rm *.sam

echo "End circexplorer2 for ${sample} at `date`"