#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PRJNA312948.txt
indir=/home/zhou/raid/IO_RNA/PRJNA312948/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PRJNA312948
nthreads=8
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PRJNA312948_call.log &
