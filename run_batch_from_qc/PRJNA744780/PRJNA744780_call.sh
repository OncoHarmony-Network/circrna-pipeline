#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PRJNA744780.txt
indir=/home/zhou/raid/IO_RNA/PRJNA744780/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PRJNA744780
nthreads=8
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PRJNA744780_call.log &
