#!/usr/bin/env bash

source activate circRNA_finder

# 0. Config
ncpu=20
sample=go28915_ngs_rna_wts_rnaaccess_EA_5354d4ff11_20170520
prefix=${sample}
fasta=/home/data/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa
gtf=/home/data/reference/hg38_ek12/gencode.v34.annotation.gtf
gdir=/home/data/reference/hg38_ek12/STAR_index_2.7.10b
indir=/home/data/EGA/OAK/raw
oudir=/home/data/circ_test

#STAR --runThreadN 60 --runMode genomeGenerate --genomeDir /home/data/reference/hg38_ek12/STAR_index_2.7.10b --genomeFastaFiles /home/data/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa

#========================================================
outdir2=${oudir}/circRNA_finder
mkdir -p ${outdir2}
cd ${outdir2}

echo "Start circRNA_finder for ${sample} at `date`"
echo "1. Aligning reads..."

STAR --readFilesIn ${indir}/${sample}_1.fastq.gz ${indir}/${sample}_2.fastq.gz \
--runThreadN 20 --genomeDir ${gdir} \
--chimSegmentMin 20 --chimScoreMin 1 --alignIntronMax 100000 \
--chimOutType Junctions SeparateSAMold --outFilterMismatchNmax 4 \
--alignTranscriptsPerReadNmax 100000 --outFilterMultimapNmax 2 \
--outFileNamePrefix ${sample}_ \
--readFilesCommand zcat

echo "2. Analyzing reads..."
postProcessStarAlignment.pl ${outdir2} ${outdir2}

echo "Done for ${sample}, final result is ${prefix}.circRNA_finder.bed"
echo "End circRNA_finder for ${sample} at `date`"