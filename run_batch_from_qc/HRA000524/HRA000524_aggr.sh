#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/HRA000524

nohup bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./HRA000524.txt" &> HRA000524_aggr.log &
