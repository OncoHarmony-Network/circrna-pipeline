#!/usr/bin/env bash

srcdir=/home/circrna/circrna-pipeline/run_batch_from_qc
workdir=/home/zhou/raid/IO_RNA/circRNA
mkdir ${workdir}/aggr_results

for i in PHS000452 PHS003284 PHS003316 PHS001427 PHS001919 EGA_IMmotion150 PHS001493 PHS002176 PRJEB25780 PRJNA356761 PRJNA744780 EGAD00001006282 EGA_POPLAR HRA000524 PHS001038 PHS001464 PRJEB23709 PRJNA312948 PRJNA476140 PRJNA940989
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
