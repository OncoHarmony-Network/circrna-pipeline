#!/usr/bin/env bash

fqfile=./POPLAR_RNA.txt
indir=/home/zhou/raid/EGA/POPLAR/raw
oudir=/home/zhou/raid/CIRC_PIPE_RESULTS/EGA_POPLAR
nthreads=20
config=/home/circrna/circrna-pipeline/config_zhou.sh

../common/ll_fq.py ${indir} --output ${fqfile}

bash ../caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config}
#nohup bash ../caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} &> EGA_OAK.log &
