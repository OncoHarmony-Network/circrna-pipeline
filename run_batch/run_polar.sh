#!/usr/bin/env bash

fqfile=./POPLAR_RNA.txt
#fqfile=./POPLAR_test.txt
indir=/home/zhou/raid/EGA/POPLAR/raw
oudir=/home/zhou/raid/CIRC_PIPE_RESULTS/EGA_POPLAR
nthreads=20
config=/home/circrna/circrna-pipeline/config_zhou.sh

#../common/ll_fq.py ${indir} --output ${fqfile}

nohup bash ../caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> EGA_POPLAR.log &
