#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PRJEB25780.txt
indir=/home/zhou/raid/IO_RNA/PRJEB25780/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PRJEB25780
nthreads=2
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PRJEB25780_call.log &
