#!/bin/bash
#/extraspace/yye1/tools/miniconda2/bin/python
for var in $(ls ./alignment_ht2-2) #$(ls *_1.fq.gz)
do
echo $var
sample=${var}  #%_1.fq.gz*};
dir_alignment='/work/circRNA/alignment_ht2-2'
dir_findcirc='/work/circRNA/FindCirc'
mkdir -p ${dir_findcirc}/${sample}
unmap=${dir_alignment}/${sample}/${sample}'_unmapped.bam'
unmap_fq=${dir_alignment}/${sample}/${sample}'_unmapped.fastq'
unmap2anch='software/RNA/circRNA/call_cirRNA/find_circ/unmapped2anchors.py'
unmap_anchor=${dir_findcirc}/${sample}/${sample}'_unmapped_anchor.fastq'
python2 ${unmap2anch} ${unmap} > ${unmap_anchor}
bt2='software/RNA/circRNA/call_cirRNA/bin/bowtie2'
bt2_index='/software/RNA/circRNA/call_cirRNA/ref/fa/hisat2_index/bowtie2_index/gencode_v28'
fa='/software/RNA/circRNA/call_cirRNA/ref/fa/gencode_v28_genome.fa'
find_circ='/work/dy/software/RNA/circRNA/call_cirRNA/find_circ/find_circ.py'
findcirc_log=${dir_findcirc}/${sample}/${sample}'.log'
findcirc_bed=${dir_findcirc}/${sample}/${sample}'.bed'
findcirc_read=${dir_findcirc}/${sample}/${sample}'.reads'
findcirc_final=${dir_findcirc}/${sample}/${sample}'_final.bed'
${bt2} -p 80 --reorder --quiet --mm --score-min=C,-15,0 -q -x ${bt2_index} -U ${unmap_anchor} | \
python2 ${find_circ} -G ${fa} -p find_circ -s ${findcirc_read} > ${findcirc_bed} 2> ${findcirc_log}
maxlen='/software/RNA/circRNA/call_cirRNA/find_circ/maxlength.py'
grep CIRCULAR ${findcirc_bed} | grep -v chrM | awk '$5>=2' | grep UNAMBIGUOUS_BP | grep ANCHOR_UNIQUE | \
python ${maxlen} 100000 > ${findcirc_final}
done