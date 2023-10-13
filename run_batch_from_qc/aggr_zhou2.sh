#!/usr/bin/env bash

workdir=/home/data/IO_RNA/circRNA
mkdir ${workdir}/aggr_results

for i in EGA_OAK EGA_IMmotion151 EGA_IMvigor010
do
    echo handling $i
    cp ${workdir}/${i}/aggr/aggr_circRNA.tsv.gz ${workdir}/aggr_results/${i}.aggr_circRNA.tsv.gz 
    cp ${workdir}/${i}/aggr/${i}.circRNA_all.txt ${workdir}/aggr_results
done

echo Done
