#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PRJNA744780

nohup bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PRJNA744780.txt" &> PRJNA744780_aggr.log &
