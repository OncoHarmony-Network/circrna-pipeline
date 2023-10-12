#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PHS001464

nohup bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PHS001464.txt" &> PHS001464_aggr.log &
