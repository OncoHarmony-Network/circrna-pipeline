#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PRJNA476140

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PRJNA476140.txt" &> PRJNA476140_aggr.log
