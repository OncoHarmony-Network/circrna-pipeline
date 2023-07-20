#!/usr/bin/env bash
#set -euxo pipefail

source activate CIRIquant

sample=$1
indir=$2
oudir=$3
ncpu=$4
prefix=${sample}
config=/home/circrna/circrna-pipeline/CIRIquant/hg38.yml

#========================================================
outdir2=${oudir}/CIRI
mkdir -p ${outdir2}
cd ${outdir2}

if [ -f ../${prefix}.CIRI.bed ] && [ -s ../${prefix}.CIRI.bed ]; then
    echo "Final result exists and is not empty, skipped this sample."
    exit 0
elif [ -f ../${prefix}.CIRI.bed ]; then
    echo "Final result file exists but is empty, re-run it."
else
    echo "Final result file does not exist, run it."
fi

echo "Start CIRIquant for ${sample} at `date`"

CIRIquant -t ${ncpu} \
        -1 ${indir}/${sample}_1.fastq.gz \
        -2 ${indir}/${sample}_2.fastq.gz \
        --config ${config} \
        --no-gene \
        -o ${outdir2} \
        -p ${sample} \
        -v

grep -v "#" ${prefix}.gtf | awk '{print $14}' | cut -d '.' -f1 > ${prefix}.counts
grep -v "#" ${prefix}.gtf | awk -v OFS="\t" '{gsub(/[";]/, "", $20); gsub(/[";]/, "", $22); print $1,$4-1,$5,$7,$20,$22}' > ${prefix}.tmp
paste ${prefix}.tmp ${prefix}.counts > ../${prefix}.CIRI.bed
rm ${prefix}.tmp ${prefix}.counts
rm -rf align circ

echo "Done for ${sample}, final result should be ${prefix}.CIRI.bed"
echo "End CIRIquant for ${sample} at `date`"