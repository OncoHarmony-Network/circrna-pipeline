#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./EGA_IMmotion150.txt
indir=/home/zhou/raid/IO_RNA/EGA_IMmotion150/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/EGA_IMmotion150
nthreads=20
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> EGA_IMmotion150_call.log &
