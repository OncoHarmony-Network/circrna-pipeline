#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PHS000452.txt
indir=/home/zhou/raid/IO_RNA/PHS000452/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PHS000452
nthreads=10
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PHS000452_call.log &
