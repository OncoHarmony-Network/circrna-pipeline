#!/usr/bin/env bash

fqfile=$1
indir=$2
outdir=$3
nthreads=$4
fp=$5
mqc=$6

mkdir -p ${outdir}

for sample in $(cat $fqfile)
do
    ${fp} -i ${indir}/${sample}_1.fastq.gz -I ${indir}/${sample}_2.fastq.gz -o ${outdir}/${sample}_1.fastq.gz -O ${outdir}/${sample}_2.fastq.gz \
        -j ${outdir}/${sample}_fastp.json -h ${outdir}/${sample}_fastp.html -w ${nthreads} --dont_overwrite
done

if [ -z "$mqc" ]; then
    echo "No multiQC set, skip it"
else 
    ${mqc} ${outdir} -o ${outdir}
fi
