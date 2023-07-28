#!/usr/bin/env bash

py=/home/circrna/miniconda3/bin/python3
fp=/home/circrna/miniconda3/bin/fastp
PIPELINE=/home/circrna/circrna-pipeline

fqfile=./EGA_IMmotion150.txt
indir=/home/zhou/t12a/EGA/EGAD00001004183/RNA/raw
oudir=/home/zhou/raid/IO_RNA/EGA_IMmotion150/fq
nthreads=20

${py} ${PIPELINE}/common/ll_fq.py ${indir} --output ${fqfile}

nohup bash ${PIPELINE}/qc/fp.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${fp} &> EGA_IMmotion150_qc.log &
