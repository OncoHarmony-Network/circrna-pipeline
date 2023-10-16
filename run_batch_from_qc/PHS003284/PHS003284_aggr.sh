#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PHS003284

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PHS003284.txt" &> PHS003284_aggr.log
