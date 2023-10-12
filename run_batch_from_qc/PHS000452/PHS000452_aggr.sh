#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PHS000452

nohup bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PHS000452.txt" &> PHS000452_aggr.log &
