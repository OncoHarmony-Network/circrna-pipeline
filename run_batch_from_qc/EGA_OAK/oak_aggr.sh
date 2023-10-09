#!/usr/bin/env bash

workdir=/home/data/IO_RNA/circRNA/EGA_OAK

nohup ../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr &> EGA_OAK_aggr.log &
nohup ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./EGA_OAK.txt &>> EGA_OAK_aggr.log &