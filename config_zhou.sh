# Config file for batch run in zhou
# All required align index should be generated

# Common
fasta=/home/zhou/t12b/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa
gtf=/home/zhou/t12b/reference/hg38_ek12/gencode.v34.annotation.gtf

# Circexplorer2
ann_ref=/home/zhou/t12b/reference/hg38_ek12/hg38_ref_all.txt 

# circRNA_finder
#STAR --runThreadN 40 --runMode genomeGenerate --genomeDir /home/zhou/t12b/reference/hg38_ek12/STAR_index_star_2.7.10b --genomeFastaFiles /home/zhou/t12b/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa
gdir=/home/zhou/t12b/reference/hg38_ek12/STAR_index_star_2.7.10b

# CIRIquant
# bwa index -a bwtsw -p /home/zhou/t12b/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa /home/zhou/t12b/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa
# hisat2-build -p 40 /home/zhou/t12b/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa /home/zhou/t12b/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa
CIRI_config=/home/circrna/circrna-pipeline/CIRIquant/hg38.zhou.yml

# find_circle
# bowtie2-build --threads 20 /home/zhou/t12b/reference/hg38_ek12/GRCh38.primary_assembly.genome.fa /home/zhou/t12b/reference/hg38_ek12/GRCh38.primary_assembly.bt2
bt2_INDEX=/home/zhou/t12b/reference/hg38_ek12/GRCh38.primary_assembly.bt2
