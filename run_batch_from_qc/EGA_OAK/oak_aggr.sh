#!/usr/bin/env bash

workdir=/home/data/IO_RNA/circRNA/EGA_OAK

bash -c "../../aggr/aggr_beds.R ${workdir} ${workdir}/aggr && ../../aggr/aggr_dataset.R ${workdir}/aggr ${workdir}/aggr ./EGA_OAK.txt" &> EGA_OAK_aggr.log
