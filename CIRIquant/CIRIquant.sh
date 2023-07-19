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

if [ -f ../${prefix}.CIRI.ok ]; then
    echo "Final result file detected, skipping this sample."
    exit 0
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

# 获取上一个命令的退出状态码
exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo "Done for ${sample}, final result is ${prefix}.CIRI.bed"
    touch ../${prefix}.CIRI.ok
else
    if [ -f ../${prefix}.CIRI.ok ]; then
        rm ../${prefix}.CIRI.ok
    fi
fi

rm -rf align circ

echo "End CIRIquant for ${sample} at `date`"