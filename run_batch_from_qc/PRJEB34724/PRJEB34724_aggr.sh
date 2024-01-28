#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PRJEB34724

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PRJEB34724.txt" &> PRJEB34724_aggr.log
