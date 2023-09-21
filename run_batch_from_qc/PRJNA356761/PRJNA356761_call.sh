#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PRJNA356761.txt
indir=/home/zhou/raid/IO_RNA/PRJNA356761/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PRJNA356761
nthreads=10
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PRJNA356761_call.log &
