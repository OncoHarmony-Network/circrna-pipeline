#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PRJEB25780

nohup bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PRJEB25780.txt" &> PRJEB25780_aggr.log &
