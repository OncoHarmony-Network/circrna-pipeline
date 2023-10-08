#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PHS001038.txt
indir=/home/zhou/raid/IO_RNA/PHS001038/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PHS001038
nthreads=8
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PHS001038_call.log &
