#!/usr/bin/env bash

py=/home/data2/home/wsx/miniconda3/bin/python3
fp=fastp
multiqc=multiqc
PIPELINE=/home/data2/Projects/circrna-pipeline

fqfile=./PHS001038.txt
indir=/home/data3/IO_Raw/ncbi/dbGaP-24835/RNA_phs001038/raw/
oudir=/home/data2/IO_RNA/PHS001038/fq
nthreads=20

#${py} ${PIPELINE}/common/ll_fq.py ${indir} --output ${fqfile}

nohup bash ${PIPELINE}/qc/fp.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${fp} ${multiqc} &> PHS001038_qc.log &
