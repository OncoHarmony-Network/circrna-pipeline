#!/usr/bin/env bash

# example
# ./fp.sh /home/data/EGA/OAK/raw go28915_ngs_rna_wts_rnaaccess_EA_5354d4ff11_20170520 /home/data/fastp_TEST

indir=$1
sample=$2
outdir=$3

mkdir -p ${outdir}

fastp -i ${indir}/${sample}_1.fastq.gz -I ${indir}/${sample}_2.fastq.gz -o ${outdir}/${sample}_1.fastq.gz -O ${outdir}/${sample}_2.fastq.gz \
    -j ${outdir}/${sample}_fastp.json -h ${outdir}/${sample}_fastp.html -w 16 --dont_overwrite

