#!/usr/bin/env bash
set -euxo pipefail

unmapped2anchors.py $bam | gzip > ${prefix}_anchors.qfa.gz

INDEX=`find -L ./ -name "*.rev.1.bt2" | sed "s/.rev.1.bt2//"`
[ -z "\$INDEX" ] && INDEX=`find -L ./ -name "*.rev.1.bt2l" | sed "s/.rev.1.bt2l//"`
[ -z "\$INDEX" ] && echo "Bowtie2 index files not found" 1>&2 && exit 1

bowtie2 \\
    --threads $task.cpus \\
    --reorder \\
    --mm \\
    -D 20 \\
    --score-min=C,-15,0 \\
    -q \\
    -x \$INDEX \\
    -U $anchors | \\
    find_circ.py  --genome=$fasta --prefix=${prefix} --stats=${prefix}.sites.log --reads=${prefix}.sites.reads > ${prefix}.sites.bed

prefix=

grep CIRCULAR $bed | \
    grep -v chrM | \
    awk '\$5>=${bsj_reads}' | \
    grep UNAMBIGUOUS_BP | grep ANCHOR_UNIQUE | \
    maxlength.py 100000 \
    > ${prefix}.txt

tail -n +2 ${prefix}.txt | awk -v OFS="\t" '{print \$1,\$2,\$3,\$6,\$5}' > ${prefix}_find_circ.bed

awk -v OFS="\t" '{print \$1, \$2, \$3, \$1":"\$2"-"\$3":"\$4, \$5, \$4}' ${prefix}_find_circ.bed > ${prefix}_find_circ_circs.bed