#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PHS001493

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PHS001493.txt" &> PHS001493_aggr.log
