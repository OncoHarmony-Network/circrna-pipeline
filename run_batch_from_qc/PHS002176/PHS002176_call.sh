#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PHS002176.txt
indir=/home/zhou/raid/IO_RNA/PHS002176/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PHS002176
nthreads=8
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PHS002176_call.log &
