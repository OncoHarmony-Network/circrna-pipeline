#!/usr/bin/env bash

py=/home/circrna/miniconda3/bin/python3
fp=/home/circrna/miniconda3/bin/fastp
PIPELINE=/home/circrna/circrna-pipeline

fqfile=./EGA_IMmotion151.txt
indir=/home/data/IO_RNA/EGA_IMmotion151/redownload_data
oudir=/home/data/IO_RNA/EGA_IMmotion151/redownload_data_fq
nthreads=20

${py} ${PIPELINE}/common/ll_fq.py ${indir} --output ${fqfile}

bash ${PIPELINE}/qc/fp.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${fp} &> EGA_IMmotion151_qc.log
