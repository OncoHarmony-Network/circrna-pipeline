#!/usr/bin/env bash

workdir=/home/data/IO_RNA/circRNA/EGA_IMvigor210

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./EGA_IMvigor210.txt" &> EGA_IMvigor210_aggr.log 