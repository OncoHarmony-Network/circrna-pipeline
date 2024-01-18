#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PRJNA795330

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PRJNA795330.txt" &> PRJNA744780_aggr.log
