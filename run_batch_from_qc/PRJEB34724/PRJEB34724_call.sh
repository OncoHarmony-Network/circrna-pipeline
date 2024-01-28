#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PRJEB34724.txt
indir=/home/zhou/raid/IO_RNA/PRJEB34724/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PRJEB34724
nthreads=24
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PRJEB34724_call.log &
