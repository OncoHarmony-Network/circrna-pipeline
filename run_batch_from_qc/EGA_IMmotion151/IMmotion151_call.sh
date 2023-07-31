#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./EGA_IMmotion151.txt
indir=/home/data/IO_RNA/EGA_IMmotion151/fq
oudir=/home/data/IO_RNA/circRNA/EGA_IMmotion151
nthreads=16
config=/home/circrna/circrna-pipeline/config_zhou2.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> EGA_IMmotion151_call.log &
