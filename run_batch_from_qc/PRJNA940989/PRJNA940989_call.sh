#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PRJNA940989.txt
indir=/home/zhou/raid/IO_RNA/PRJNA940989/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PRJNA940989
nthreads=2
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PRJNA940989_call.log &
