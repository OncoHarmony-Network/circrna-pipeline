1. Download reference

   https://support.10xgenomics.com/single-cell-gene-expression/software/release-notes/build#GRCh38_2020A

2. Create Env and setting

```
conda create -n circexplorer2 python=3.7
conda activate circexplorer2
pip install circexplorer2
# download ref
fetch_ucsc.py hg38 ref ./reference/hg38_ref.txt
mamba install bwa
# bwa index
bwa index Homo_sapiens.GRCh38.dna.primary_assembly.fa 
```

3. Run the pipeline

```
ncpu=20
sample=MED8A
prefix=${sample}
indir=./test_data
oudir=./circ_circexplorer2_out
fasta='./reference/reference_sources/Homo_sapiens.GRCh38.dna.primary_assembly.fa'
unmap_bwa_sam=${oudir}/${sample}/${sample}'_unmapped_bwa.sam'
ann_ref='./reference/hg38_ref.txt'
mkdir -p ${oudir}/${sample}
# step1
bwa mem -t ${ncpu} ${fasta} ${indir}/${sample}_1.fastq.gz ${indir}/${sample}_2.fastq.gz > ${unmap_bwa_sam}
# step2
CIRCexplorer2 parse -t BWA -b ${oudir}/${sample}/${sample}'_circ2_result.txt' ${unmap_bwa_sam} > ${oudir}/${sample}/${sample}'_test.parse.log'
# step3
CIRCexplorer2 annotate -r ${ann_ref} -g ${fasta} -b ${oudir}/${sample}/${sample}'_circ2_result.txt' -o ${oudir}/${sample}/${sample}'_circ2_result_ann.circ2'
```

