#!/usr/bin/env bash

workdir=/home/data/IO_RNA/circRNA/EGA_IMmotion151

nohup ../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr &> EGA_IMmotion151_aggr.log &
nohup ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./EGA_IMmotion151.txt &>> EGA_IMmotion151_aggr.log &