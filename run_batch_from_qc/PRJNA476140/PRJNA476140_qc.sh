#!/usr/bin/env bash

py=/home/circrna/miniconda3/bin/python3
fp=/home/circrna/miniconda3/bin/fastp
multiqc=/home/circrna/miniconda3/bin/multiqc
PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PRJNA476140.txt
indir=/home/zhou/t12a/PRJNA476140/raw
oudir=/home/zhou/raid/IO_RNA/PRJNA476140/fq
nthreads=20

${py} ${PIPELINE}/common/ll_fq.py ${indir} --output ${fqfile}

nohup bash ${PIPELINE}/qc/fp.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${fp} ${multiqc} &> PRJNA476140_qc.log &
