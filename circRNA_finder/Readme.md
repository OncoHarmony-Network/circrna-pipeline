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
oudir='./circ_circfinder_out'
fa='./reference/reference_sources/Homo_sapiens.GRCh38.dna.primary_assembly.fa'
gtf='./reference/reference_sources/gencode.v32.primary_assembly.annotation.gtf'
gdir='./reference/reference_sources/star_index'
mkdir -p ${oudir}/${sample}

# you can change thread in the runstar.pl file (default: 4)
perl ${runStar} --inFile1 ${indir}/${sample}_1.fastq.gz --inFile2 ${indir}/${sample}_2.fastq.gz} --genomeDir ${gdir} --outPrefix ${oudir}/${sample}


perl ${pstalign} ${oudir}/${sample} ${oudir}/${sample}
```

