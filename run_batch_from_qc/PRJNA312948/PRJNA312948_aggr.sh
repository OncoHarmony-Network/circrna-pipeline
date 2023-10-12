#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PRJNA312948

nohup bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PRJNA312948.txt" &> PRJNA312948_aggr.log &
