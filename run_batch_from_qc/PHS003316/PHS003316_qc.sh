#!/usr/bin/env bash

py=/home/data2/home/wsx/miniconda3/bin/python3
fp=fastp
multiqc=multiqc
PIPELINE=/home/data2/Projects/circrna-pipeline

fqfile=./PHS003316.txt
indir=/home/data3/IO_Raw/ncbi/dbGaP-24835/RNA_phs003316/raw/
oudir=/home/data2/IO_RNA/PHS003316/fq
nthreads=16

${py} ${PIPELINE}/common/ll_fq.py ${indir} --output ${fqfile}

nohup bash ${PIPELINE}/qc/fp.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${fp} ${multiqc} &> PHS003316_qc.log &
