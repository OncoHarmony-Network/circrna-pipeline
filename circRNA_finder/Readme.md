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

perl ${pstalign} ${oudir}/${sample} ${oudir}/${sample}
```

