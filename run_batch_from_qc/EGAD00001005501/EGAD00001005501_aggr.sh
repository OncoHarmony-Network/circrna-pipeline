#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/EGAD00001005501

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./EGAD00001005501.txt" &> EGAD00001005501_aggr.log 
