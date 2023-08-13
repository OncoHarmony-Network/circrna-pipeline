#!/usr/bin/env bash

PIPELINE=/home/circrna/circrna-pipeline

fqfile=./EGA_IMvigor010.txt
indir=/home/data/IO_RNA/EGA_IMvigor010/fq
oudir=/home/data/IO_RNA/circRNA/EGA_IMvigor010
nthreads=6
config=/home/circrna/circrna-pipeline/config_zhou2.sh

nohup bash ${PIPELINE}/caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> EGA_IMvigor010_call.log &
