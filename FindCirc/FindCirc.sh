#!/usr/bin/env bash
set -euxo pipefail

source activate FindCirc

# 0. Config 
ncpu=20
sample=go28915_ngs_rna_wts_rnaaccess_EA_5354d4ff11_20170520
prefix=${sample}
#bowtie2-build ce6.fa bt2_ce6 
INDEX='/software/RNA/circRNA/call_cirRNA/ref/fa/hisat2_index/bowtie2_index/gencode_v28'
indir=/home/data/EGA/OAK/raw
oudir=/home/data/circ_test

# 1. FIND_CIRC_ALIGN( reads, bowtie2_index.collect(), false, true )
bowtie2 \
        -x ${INDEX} \
        -1 ${indir}/${sample}_1.fastq.gz -2 ${indir}/${sample}_2.fastq.gz \
        --un-conc-gz ${prefix}.unmapped.fastq.gz \
        --threads ${ncpu} \
        --very-sensitive --mm -D 20 --score-min=C,-15,0 -q \
        2> ${prefix}.bowtie2.log \
        | samtools sort --threads ${ncpu} -o ${prefix}.bam -

 if [ -f ${prefix}.unmapped.fastq.1.gz ]; then
        mv ${prefix}.unmapped.fastq.1.gz ${prefix}.unmapped_1.fastq.gz
    fi

    if [ -f ${prefix}.unmapped.fastq.2.gz ]; then
        mv ${prefix}.unmapped.fastq.2.gz ${prefix}.unmapped_2.fastq.gz
    fi

# 2. SAMTOOLS_INDEX( FIND_CIRC_ALIGN.out.bam )

# 3. SAMTOOLS_VIEW( FIND_CIRC_ALIGN.out.bam.join( SAMTOOLS_INDEX.out.bai ), fasta, [] )

# 4. FIND_CIRC_ANCHORS( SAMTOOLS_VIEW.out.bam )

# 5. FIND_CIRC( FIND_CIRC_ANCHORS.out.anchors, bowtie2_index.collect(), fasta )

# 6. find_circ_filter = FIND_CIRC.out.bed.map{ meta, bed -> meta.tool = "find_circ"; return [ meta, bed ] }

# 7. FIND_CIRC_FILTER( find_circ_filter, bsj_reads )



unmapped2anchors.py $bam | gzip > ${prefix}_anchors.qfa.gz

INDEX=$(find -L ./ -name "*.rev.1.bt2" | sed "s/.rev.1.bt2//")
[ -z "\$INDEX" ] && INDEX=$(find -L ./ -name "*.rev.1.bt2l" | sed "s/.rev.1.bt2l//")
[ -z "\$INDEX" ] && echo "Bowtie2 index files not found" 1>&2 && exit 1

bowtie2 \\
    --threads ${ncpu} \\
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