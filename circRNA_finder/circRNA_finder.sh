#!/usr/bin/env bash

source activate circRNA_finder

# 0. Config
sample=$1
indir=$2
oudir=$3
ncpu=$4
prefix=${sample}

config=$5
source ${config}

#========================================================
outdir2=${oudir}/${prefix}.circRNA_finder
mkdir -p ${outdir2}
cd ${outdir2}

echo "Start circRNA_finder for ${sample} at `date`"

if [ -f ../${prefix}.circRNA_finder.bed ] && [ -s ../${prefix}.circRNA_finder.bed ]; then
    echo "Final result exists and is not empty, skipped this sample."
    exit 0
elif [ -f ../${prefix}.circRNA_finder.bed ]; then
    echo "Final result file exists but is empty, re-run it."
else
    echo "Final result file does not exist, run it."
fi

rm -rf ${outdir2}/*

echo "1. Aligning reads..."

STAR --readFilesIn ${indir}/${sample}_1.fastq.gz ${indir}/${sample}_2.fastq.gz \
--runThreadN ${ncpu} --genomeDir ${gdir} \
--chimSegmentMin 20 --chimScoreMin 1 --alignIntronMax 100000 \
--chimOutType Junctions SeparateSAMold --outFilterMismatchNmax 4 \
--alignTranscriptsPerReadNmax 100000 --outFilterMultimapNmax 2 \
--outFileNamePrefix ${sample}. \
--readFilesCommand zcat

echo "2. Analyzing reads..."
postProcessStarAlignment.pl --starDir ./ --outDir ./

echo "3. Outputing..."
awk -v OFS="\t" -F"\t" '{print $1,$2,$3,$6,$5}' ${prefix}.filteredJunctions.bed > ../${prefix}.circRNA_finder.bed

rm *.sam *.bam *.bai

echo "Done for ${sample}, final result should be ${prefix}.circRNA_finder.bed"
echo "End circRNA_finder for ${sample} at `date`"