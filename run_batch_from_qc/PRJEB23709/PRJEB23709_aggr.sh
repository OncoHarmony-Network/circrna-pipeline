#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PRJEB23709

nohup bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PRJEB23709.txt" &> PRJEB23709_aggr.log &
