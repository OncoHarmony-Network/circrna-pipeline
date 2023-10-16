#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PHS001919

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PHS001919.txt" &> PHS001919_aggr.log
