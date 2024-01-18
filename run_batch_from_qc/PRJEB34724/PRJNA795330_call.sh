#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PRJNA795330.txt
indir=/home/zhou/raid/IO_RNA/PRJNA795330/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PRJNA795330
nthreads=24
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PRJNA744780_call.log &
