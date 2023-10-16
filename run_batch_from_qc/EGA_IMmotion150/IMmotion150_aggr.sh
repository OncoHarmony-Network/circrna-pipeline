#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/EGA_IMmotion150

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./EGA_IMmotion150.txt" &> EGA_IMmotion150_aggr.log
