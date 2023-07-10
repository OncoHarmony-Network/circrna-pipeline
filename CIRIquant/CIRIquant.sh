#!/usr/bin/env bash
#set -euxo pipefail

source activate CIRIquant
#cd ./test_data/quant
#bwa index -a bwtsw -p chr1.fa chr1.fa
#hisat2-build ./chr1.fa ./chr1.fa

sample=go28915_ngs_rna_wts_rnaaccess_EA_5354d4ff11_20170520
indir=/home/data/EGA/OAK/raw
oudir=/home/data/circ_test
config=/home/circrna/circrna-pipeline/CIRIquant/hg38.yml

CIRIquant -t 4 \
        -1 ${indir}/${sample}_1.fastq.gz \
        -2 ${indir}/${sample}_2.fastq.gz \
        --config ${config} \
        --no-gene \
        -o ${oudir} \
        -p ${sample}

#grep -v "#" ${prefix}.gtf | awk '{print \$14}' | cut -d '.' -f1 > counts
#grep -v "#" ${prefix}.gtf | awk -v OFS="\t" '{print \$1,\$4,\$5,\$7}' > ${prefix}.tmp
#paste ${prefix}.tmp counts > ${prefix}_unfilt.bed

#awk '{if(\$5 >= ${bsj_reads}) print \$0}' ${prefix}_unfilt.bed > ${prefix}_filt.bed
#grep -v '^\$' ${prefix}_filt.bed > ${prefix}_ciriquant

#awk -v OFS="\t" '{\$2-=1;print}' ${prefix}_ciriquant > ${prefix}_ciriquant.bed
#rm ${prefix}.gtf

#awk -v OFS="\t" '{print \$1, \$2, \$3, \$1":"\$2"-"\$3":"\$4, \$5, \$4}' ${prefix}_ciriquant.bed > ${prefix}_ciriquant_circs.bed