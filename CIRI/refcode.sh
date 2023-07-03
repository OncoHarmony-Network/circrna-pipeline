#!/bin/bash 
##Start location need -1
##
for var in $(ls ./alignment_ht2) #*_1.fq.gz)
do
echo $var
sample=${var}  #%_1.fq.gz*};
ciri2='/software/RNA/circRNA/call_cirRNA/CIRI_v2.0.6/CIRI2.pl'
#dir_alignment='/extraspace/sli/circRNA01/alignment_ht2'
dir_circ='/work/circRNA/Circ'
dir_ciri='/work/circRNA/Ciri'
mkdir -p ${dir_ciri}/${sample}
unmap_bwa_sam=${dir_circ}/${sample}/${sample}'_unmapped_bwa.sam'
fa='software/RNA/circRNA/call_cirRNA/ref/fa/gencode_v28_genome.fa'
gtf='software/RNA/circRNA/call_cirRNA/ref/fa/gencode_v28_annotation.gtf'
ciri_out=${dir_ciri}/${sample}/${sample}'_circrna.ciri'
perl ${ciri2} -T 50 -I ${unmap_bwa_sam} -O ${ciri_out} -F ${fa} -A ${gtf} -G ${dir_ciri}/${sample}/${sample}'_ciri.log'
done