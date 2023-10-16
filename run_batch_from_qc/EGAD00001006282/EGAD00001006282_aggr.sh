#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/EGAD00001006282

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./EGAD00001006282.txt" &> EGAD00001006282_aggr.log
