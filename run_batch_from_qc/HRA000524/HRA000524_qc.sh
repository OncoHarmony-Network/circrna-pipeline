#!/usr/bin/env bash

py=/home/circrna/miniconda3/bin/python3
fp=/home/circrna/miniconda3/bin/fastp
PIPELINE=/home/circrna/circrna-pipeline

fqfile=./HRA000524.txt
indir=/home/zhou/t12a/HRA000524/raw
oudir=/home/zhou/raid/IO_RNA/HRA000524/fq
nthreads=20

${py} ${PIPELINE}/common/ll_fq.py ${indir} --output ${fqfile}

#nohup bash ${PIPELINE}/qc/fp.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${fp} &> HRA000524_qc.log &
