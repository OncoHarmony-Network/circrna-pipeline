#!/usr/bin/env bash

fqfile=$1
indir=$2
outdir=$3
nthreads=$4
fp=$5
mqc=$6

mkdir -p ${outdir}

if [ -f fastp.failed.txt ]; then
    echo "Previous failed sample list file detected, remove it"
    rm fastp.failed.txt
fi

for sample in $(cat $fqfile)
do
    if [ -f ${outdir}/${sample}_fastp.html ]; then
        echo "QC file for ${sample} has been detected, skip this sample"
    else
        ${fp} -i ${indir}/${sample}_*1*f*q.gz -I ${indir}/${sample}_*2*f*q.gz -o ${outdir}/${sample}_1.fastq.gz -O ${outdir}/${sample}_2.fastq.gz \
            -j ${outdir}/${sample}_fastp.json -h ${outdir}/${sample}_fastp.html -w ${nthreads}
        
        if [ $? -ne 0 ]; then
            echo "Sample ${sample} is failed"
            echo "${sample}" >> fastp.failed.txt
        fi
    fi
done

if [ -z "$mqc" ]; then
    echo "No multiQC set, skip it"
else 
    ${mqc} ${outdir} -o ${outdir}
fi
