#!/usr/bin/env bash
#set -euxo pipefail

source activate CIRIquant

sample=go28915_ngs_rna_wts_rnaaccess_EA_5354d4ff11_20170520
prefix=${sample}
indir=/home/data/EGA/OAK/raw
oudir=/home/data/circ_test
config=/home/circrna/circrna-pipeline/CIRIquant/hg38.yml

CIRIquant -t 20 \
        -1 ${indir}/${sample}_1.fastq.gz \
        -2 ${indir}/${sample}_2.fastq.gz \
        --config ${config} \
        --no-gene \
        -o ${oudir} \
        -p ${sample} \
        -v

cd ${oudir}
grep -v "#" ${prefix}.gtf | awk '{print $14}' | cut -d '.' -f1 > ${prefix}.counts
grep -v "#" ${prefix}.gtf | awk -v OFS="\t" '{gsub(/[";]/, "", $20); gsub(/[";]/, "", $22); print $1,$4,$5,$7,$20,$22}' > ${prefix}.tmp
paste ${prefix}.tmp ${prefix}.counts > ${prefix}.bed
rm ${prefix}.tmp ${prefix}.counts

echo "Done for ${sample}"