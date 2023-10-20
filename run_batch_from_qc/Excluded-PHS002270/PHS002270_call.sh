#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./PHS002270.txt
indir=/home/zhou/raid/IO_RNA/PHS002270/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/PHS002270
nthreads=8
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> PHS002270_call.log &
