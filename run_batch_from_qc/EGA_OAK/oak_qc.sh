#!/usr/bin/env bash

py=/home/circrna/miniconda3/bin/python3
fp=/home/circrna/miniconda3/bin/fastp
PIPELINE=/home/circrna/circrna-pipeline
multiqc=/home/circrna/miniconda3/bin/multiqc

fqfile=./EGA_OAK.txt
indir=/home/data/EGA/OAK/raw
oudir=/home/data/IO_RNA/EGA_OAK/fq
nthreads=20

${py} ${PIPELINE}/common/ll_fq.py ${indir} --output ${fqfile}

nohup bash ${PIPELINE}/qc/fp.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${fp} ${multiqc} &> EGA_OAK_qc.log &
