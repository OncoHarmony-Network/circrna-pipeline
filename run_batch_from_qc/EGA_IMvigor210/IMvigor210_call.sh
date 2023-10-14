#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./EGA_IMvigor210.txt
indir=/home/data/IO_RNA/EGA_IMvigor210/fq
oudir=/home/data/IO_RNA/circRNA/EGA_IMvigor210
nthreads=30
config=/home/circrna/circrna-pipeline/config_zhou2.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> EGA_IMvigor210_call.log &
