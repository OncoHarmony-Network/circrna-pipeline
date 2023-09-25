#!/usr/bin/env bash

py=/home/circrna/miniconda3/bin/python3
fp=/home/circrna/miniconda3/bin/fastp
multiqc=/home/circrna/miniconda3/bin/multiqc
PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PHS001919.txt
indir=/home/zhou/raid/ncbi/dbGaP-24835/RNA_phs001919_PRJNA578193/raw
oudir=/home/zhou/raid/IO_RNA/PHS001919/fq
nthreads=4

${py} ${PIPELINE}/common/ll_fq.py ${indir} --output ${fqfile}

nohup bash ${PIPELINE}/qc/fp.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${fp} ${multiqc} &> PHS001919_qc.log &
