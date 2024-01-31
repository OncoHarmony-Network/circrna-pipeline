#!/usr/bin/env bash

py=/home/circrna/miniconda3/bin/python3
fp=/home/circrna/miniconda3/bin/fastp
PIPELINE=/home/circrna/circrna-pipeline

fqfile=./EGAD00001005501.txt
indir=/home/zhou/raid/EGA/EGAD00001005501/raw
oudir=/home/zhou/raid/IO_RNA/EGAD00001005501/fq
nthreads=20

${py} ${PIPELINE}/common/ll_fq.py ${indir} --output ${fqfile}

nohup bash ${PIPELINE}/qc/fp.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${fp} &> EGAD00001005501_qc.log &
