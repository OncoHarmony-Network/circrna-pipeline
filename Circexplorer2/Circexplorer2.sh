#!/usr/bin/env bash

source activate Circexplorer2

# 0. Config
sample=$1
indir=$2
oudir=$3
ncpu=$4
prefix=${sample}

config=$5
source ${config}

#========================================================
outdir2=${oudir}/${prefix}.circexplorer2
mkdir -p ${outdir2}
cd ${outdir2}

echo "Start circexplorer2 for ${sample} at `date`"

if [ -f ../${prefix}.circexplorer2.bed ] && [ -s ../${prefix}.circexplorer2.bed ]; then
    echo "Final result exists and is not empty, skipped this sample."
    exit 0
elif [ -f ../${prefix}.circexplorer2.bed ]; then
    echo "Final result file exists but is empty, re-run it."
else
    echo "Final result file does not exist, run it."
fi

rm -rf ${outdir2}/*

unmap_bwa_sam=${outdir2}/${prefix}'_unmapped_bwa.sam'

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

rm *.sam

echo "Done for ${sample}, final result should be ${prefix}.circexplorer2.bed"
echo "End circexplorer2 for ${sample} at `date`"