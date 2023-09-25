#!/usr/bin/env bash

py=/home/circrna/miniconda3/bin/python3
fp=/home/circrna/miniconda3/bin/fastp
multiqc=/home/circrna/miniconda3/bin/multiqc
PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PHS002270.txt
indir=/home/zhou/raid/ncbi/dbGaP-24835/RNA_phs002270/raw
oudir=/home/zhou/raid/IO_RNA/PHS002270/fq
nthreads=4

${py} ${PIPELINE}/common/ll_fq.py ${indir} --output ${fqfile}

nohup bash ${PIPELINE}/qc/fp.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${fp} ${multiqc} &> PHS002270_qc.log &
