#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./EGAD00001005501.txt
indir=/home/zhou/raid/IO_RNA/EGAD00001005501/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/EGAD00001005501
nthreads=1
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> EGAD00001005501_call.log &
