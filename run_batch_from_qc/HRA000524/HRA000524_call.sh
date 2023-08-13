#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./HRA000524.txt
indir=/home/zhou/raid/IO_RNA/HRA000524/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/HRA000524
nthreads=2
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> HRA000524_call.log &
