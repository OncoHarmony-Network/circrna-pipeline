#!/usr/bin/env bash

#../common/ll_fq.py ${indir} --output ${fqfile}

fqfile=/home/data/EGA/OAK/code/OAK_RNA.txt
indir=/home/data/EGA/OAK/raw
oudir=/home/data/CIRC_PIPE_RESULTS/EGA_OAK
nthreads=20

nohup bash ../caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} &> EGA_OAK.log &
