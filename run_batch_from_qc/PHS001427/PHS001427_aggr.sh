#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PHS001427

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PHS001427.txt" &> PHS001427_aggr.log
