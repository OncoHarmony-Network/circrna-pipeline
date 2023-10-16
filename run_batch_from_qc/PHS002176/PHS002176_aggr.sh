#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PHS002176

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PHS002176.txt" &> PHS002176_aggr.log
