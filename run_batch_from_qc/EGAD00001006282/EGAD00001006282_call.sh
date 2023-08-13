#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./EGAD00001006282.txt
indir=/home/zhou/raid/IO_RNA/EGAD00001006282/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/EGAD00001006282
nthreads=2
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> EGAD00001006282_call.log &
