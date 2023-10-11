#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/EGA_POPLAR

nohup bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./EGA_POPLAR.txt" &> EGA_POPLAR_aggr.log &
