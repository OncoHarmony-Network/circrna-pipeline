#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PRJEB23709.txt
indir=/home/zhou/raid/IO_RNA/PRJEB23709/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PRJEB23709
nthreads=1
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PRJEB23709_call.log &
