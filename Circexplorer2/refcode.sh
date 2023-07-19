#!/bin/bash
###CIRCexplorer2
for var in $(ls ./alignment_ht2) #*_1.fq.gz)
do
echo $var
sample=${var}  #%_1.fq.gz*};
dir_alignment='/work/circRNA/alignment_ht2'
dir_circ='/work/circRNA/Circ'
mkdir -p ${dir_circ}/${sample}
fa='/ref/fa/gencode_v28_genome.fa'
bwa='/software/RNA/circRNA/call_cirRNA/bin/bwa'
unmap_fq=${dir_alignment}/${sample}/${sample}'_unmapped.fastq'
unmap_bwa_sam=${dir_circ}/${sample}/${sample}'_unmapped_bwa.sam'
${bwa} mem -t 60 -T 19 ${fa} ${unmap_fq} > ${unmap_bwa_sam} 2> ${dir_circ}/${sample}/${sample}'_bwa.log'
circ2='/software/miniconda3/envs/RNAseq_py37/bin/CIRCexplorer2'
unmap_bwa_sam=${dir_circ}/${sample}/${sample}'_unmapped_bwa.sam'
${circ2} parse -t BWA -b ${dir_circ}/${sample}/${sample}'_circ2_result.txt' ${unmap_bwa_sam} > ${dir_circ}/${sample}/${sample}'_test.parse.log'
ann_ref='/software/RNA/circRNA/call_cirRNA/ref/hg38_ref_Circ2.txt'
${circ2} annotate -r ${ann_ref} -g ${fa} -b ${dir_circ}/${sample}/${sample}'_circ2_result.txt' -o ${dir_circ}/${sample}/${sample}'_circ2_result_ann.circ2'
done