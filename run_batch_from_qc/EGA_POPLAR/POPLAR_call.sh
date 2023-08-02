#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./EGA_POPLAR.txt
indir=/home/zhou/raid/IO_RNA/EGA_POPLAR/fq
oudir=/home/zhou/raid/IO_RNA/circRNA/EGA_POPLAR
nthreads=20
config=/home/circrna/circrna-pipeline/config_zhou.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> EGA_POPLAR_call.log &
