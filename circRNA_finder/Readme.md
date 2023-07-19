1. Create Env and setting

```
git clone https://github.com/orzechoj/circRNA_finder.git

# conda activate env
# mamba install -c bioconda star
# STAR version: 2.7.10b
# star index
STAR --runThreadN 20 --runMode genomeGenerate --genomeDir ./star_index --genomeFastaFiles ./Homo_sapiens.GRCh38.dna.primary_assembly.fa
```

2. Run pipeline

```
ncpu=20
sample=MED8A
pstalign='./software/circRNA_finder/postProcessStarAlignment.pl'
runStar='./software/circRNA_finder/runStar.pl'
indir=./test_data
oudir='./circ_circfinder_out' #使用绝对路径
fa='./reference/reference_sources/Homo_sapiens.GRCh38.dna.primary_assembly.fa'
gtf='./reference/reference_sources/gencode.v32.primary_assembly.annotation.gtf'
gdir='./reference/reference_sources/star_index'
mkdir -p ${oudir}/${sample}

/home/fan/miniconda3/envs/circexplorer2/bin/STAR --readFilesIn ${indir}/${sample}_1.fastq.gz ${indir}/${sample}_2.fastq.gz --runThreadN 20 --genomeDir ${gdir} \
--chimSegmentMin 20 --chimScoreMin 1 --alignIntronMax 100000 \
--chimOutType Junctions SeparateSAMold --outFilterMismatchNmax 4 --alignTranscriptsPerReadNmax 100000 --outFilterMultimapNmax 2 --outFileNamePrefix ${oudir}/${sample}/${sample}_ \
--readFilesCommand zcat

# use root samtools
# 这里如果用conda里面的samtools会出现权限问题，使用sudo命令运行root下安装的samtools
cd ${oudir}/${sample}

perl ${pstalign} ${oudir}/${sample} ${oudir}/${sample}
```

3. Output

a) _filteredJunctions.bed: A bed file with all circular junctions found by the pipeline. The score column indicates the number reads spanning each junction.

b) _s_filteredJunctions.bed: A bed file with those juction in (a) that are flanked by GT-AG splice sites. The score column indicates the number reads spanning each junction.

c) _s_filteredJunctions_fw.bed: A bed file with the same circular junctions as in file (b), but here the score column gives the average number of forward spliced reads at both splice sites around each circular junction.

d) (Sorted and indexed) bam file with all chimeric reads identified by STAR. The circRNA junction spanning reads are a subset of these.