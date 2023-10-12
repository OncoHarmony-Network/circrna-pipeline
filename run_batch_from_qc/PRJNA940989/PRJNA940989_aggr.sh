#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PRJNA940989

nohup bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PRJNA940989.txt" &> PRJNA940989_aggr.log &
