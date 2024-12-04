#!/usr/bin/env bash

PIPELINE=/home/data2/Projects/circrna-pipeline

fqfile=./PRJNA795330.txt
indir=/home/data2/IO_RNA/PRJNA795330/fq
oudir=/home/data2/IO_RNA/circRNA/PRJNA795330
nthreads=24
config=/home/data2/Projects/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PRJNA795330_call.log &
