#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./EGA_OAK.txt
indir=/home/data/IO_RNA/EGA_OAK/fq
oudir=/home/data/IO_RNA/circRNA/EGA_OAK
nthreads=32
config=/home/circrna/circrna-pipeline/config_zhou2.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> EGA_OAK_call.log &
