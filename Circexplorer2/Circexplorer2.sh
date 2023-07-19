#!/usr/bin/env bash

source activate Circexplorer2

# 0. Config
ncpu=20
sample=go28915_ngs_rna_wts_rnaaccess_EA_5354d4ff11_20170520
prefix=${sample}
fasta=/home/data/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa
ann_ref=/home/data/reference/hg38_ek12/hg38_ref_all.txt 
indir=/home/data/EGA/OAK/raw
oudir=/home/data/circ_test

#========================================================
outdir2=${oudir}/circexplorer2
mkdir -p ${outdir2}
cd ${outdir2}

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

echo "Done for ${sample}, final result is ${prefix}.circexplorer2.bed"
echo "End circexplorer2 for ${sample} at `date`"