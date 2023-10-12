#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PHS001038

nohup bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PHS001038.txt" &> PHS001038_aggr.log &
