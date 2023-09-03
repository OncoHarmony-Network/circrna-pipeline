#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PRJNA476140.txt
indir=/home/zhou/raid/IO_RNA/PRJNA476140/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PRJNA476140
nthreads=2
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PRJNA476140_call.log &
