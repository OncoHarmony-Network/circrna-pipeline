#!/usr/bin/env bash

srcdir=/home/circrna/circrna-pipeline/run_batch_from_qc
workdir=/home/data/IO_RNA/circRNA
mkdir ${workdir}/aggr_results

for i in EGA_OAK EGA_IMmotion151 EGA_IMvigor010
do
    echo handling $i
    echo ..aggr...
    cd ${srcdir}/${i} && bash *_aggr.sh
    echo ..copying results...
    cp ${workdir}/${i}/aggr/aggr_circRNA.tsv.gz ${workdir}/aggr_results/${i}.aggr_circRNA.tsv.gz 
    cp ${workdir}/${i}/aggr/${i}.circRNA_all.txt ${workdir}/aggr_results
    echo ..done..
done

cd ${workdir}/aggr_results && gzip *.txt

echo Done
