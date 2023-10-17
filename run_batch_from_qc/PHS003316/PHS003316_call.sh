#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PHS003316.txt
indir=/home/zhou/raid/IO_RNA/PHS003316/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PHS003316
nthreads=10
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PHS003316_call.log &
