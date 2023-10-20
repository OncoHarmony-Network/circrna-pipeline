#!/usr/bin/env bash

workdir=/home/zhou/raid/IO_RNA/circRNA/PHS002270

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./PHS002270.txt" &> PHS002270_aggr.log
