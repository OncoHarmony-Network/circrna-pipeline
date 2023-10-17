#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PHS003316

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PHS003316.txt" &> PHS003316_aggr.log
