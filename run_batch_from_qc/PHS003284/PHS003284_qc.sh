#!/usr/bin/env bash

py=/home/circrna/miniconda3/bin/python3
fp=/home/circrna/miniconda3/bin/fastp
multiqc=/home/circrna/miniconda3/bin/multiqc
PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PHS003284.txt
indir=/home/zhou/raid/ncbi/dbGaP-24835/RNA_phs003284/raw
oudir=/home/zhou/raid/IO_RNA/PHS003284/fq
nthreads=16

${py} ${PIPELINE}/common/ll_fq.py ${indir} --output ${fqfile}

nohup bash ${PIPELINE}/qc/fp.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${fp} ${multiqc} &> PHS003284_qc.log &
