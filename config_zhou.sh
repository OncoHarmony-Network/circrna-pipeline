# Config file for batch run in zhou
# All required align index should be generated

# Common
fasta=/home/data2/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa
gtf=/home/data2/reference/hg38_ek12/gencode.v34.annotation.gtf

# Circexplorer2
ann_ref=/home/data2/reference/hg38_ek12/hg38_ref_all.txt 

# circRNA_finder
#STAR --runThreadN 40 --runMode genomeGenerate --genomeDir /home/data2/reference/hg38_ek12/STAR_index_star_2.7.10b --genomeFastaFiles /home/data2/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa
gdir=/home/data2/reference/hg38_ek12/STAR_index_2.7.10b

# CIRIquant
# bwa index -a bwtsw -p /home/data2/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa /home/data2/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa
# hisat2-build -p 40 /home/data2/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa /home/data2/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa
CIRI_config=/home/data2/Projects/circrna-pipeline/CIRIquant/hg38.yml

# find_circle
# bowtie2-build --threads 20 /home/data2/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa /home/data2/reference/hg38_ek12/GRCh38.primary_assembly.bt2
bt2_INDEX=/home/data2/reference/hg38_ek12/GRCh38.primary_assembly.bt2
