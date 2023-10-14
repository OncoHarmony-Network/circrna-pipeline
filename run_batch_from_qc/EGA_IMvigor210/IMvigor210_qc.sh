#!/usr/bin/env bash

py=/home/circrna/miniconda3/bin/python3
fp=/home/circrna/miniconda3/bin/fastp
multiqc=/home/circrna/miniconda3/bin/multiqc
PIPELINE=/home/circrna/circrna-pipeline

fqfile=./EGA_IMvigor210.txt
indir=/home/data/EGA/IMvigor210/raw
oudir=/home/data/IO_RNA/EGA_IMvigor210/fq
nthreads=20

${py} ${PIPELINE}/common/ll_fq.py ${indir} --output ${fqfile}

nohup bash ${PIPELINE}/qc/fp.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${fp} ${multiqc} &> EGA_IMvigor210_qc.log &
