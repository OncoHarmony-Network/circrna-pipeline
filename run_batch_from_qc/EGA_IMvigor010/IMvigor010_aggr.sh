#!/usr/bin/env bash

workdir=/home/data/IO_RNA/circRNA/EGA_IMvigor010

nohup ../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr &> EGA_IMvigor010_aggr.log &
nohup ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./EGA_IMvigor010.txt &>> EGA_IMvigor010_aggr.log &