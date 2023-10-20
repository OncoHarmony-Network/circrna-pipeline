#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PHS003284.txt
indir=/home/zhou/raid/IO_RNA/PHS003284/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PHS003284
nthreads=56
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PHS003284_call.log &
