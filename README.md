# CircRNA Identification and Integration Pipeline

The pipeline provides an easy and reproducible way to detect circRNA from pair-end FASTQ files with four methods: CIRIquant, Circexplorer2, find_circ and circRNA_finder.

## Step 1. Install the required conda environment

1. (Optional) Set an independent linux account `circrna` for deploying and running circRNA identification pipeline.
2. Install [miniconda3](https://docs.conda.io/en/latest/miniconda.html) to default path, i.e., `~/miniconda3`.
When using recommended setting above, conda should be available at `/home/circrna/miniconda3`.
3. Install [mamba](https://mamba.readthedocs.io/en/latest/installation.html) to `base` env with `conda install -n base --override-channels -c conda-forge mamba 'python_abi=*=*cp*'`.
4. Install [just](https://just.systems/) with `curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/bin`. Please add `~/bin` here to your `$PATH`.
You can change the `~/bin` to anywhere, but you need to make the `just` available when you enter the terminal.
5. Install [rush](https://github.com/shenwei356/rush) and add its path to `$PATH`, similar
to `just`.
6. (Optional) Set registry of conda and pypi (pip) if necessary. For example, if you are in China, I recommend [https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/](https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/)
& [https://mirrors.tuna.tsinghua.edu.cn/help/pypi/](https://mirrors.tuna.tsinghua.edu.cn/help/pypi/). 
7. Now, clone this repo (`git clone git@42.192.87.178:coco/circrna-pipeline.git`).
8. Install the conda environments one by one.

    ```sh
    cd circrna-pipeline
    cd CIRIquant
    just install
    cd ../FindCirc
    just install
    cd ../Circexplorer2
    just install
    cd ../circRNA_finder
    just install
    ```

Please make sure all the conda environments have been created with required softwares.

```sh
$ conda env list
# conda environments:
#
base                  *  /home/circrna/miniconda3
CIRIquant                /home/circrna/miniconda3/envs/CIRIquant
Circexplorer2            /home/circrna/miniconda3/envs/Circexplorer2
FindCirc                 /home/circrna/miniconda3/envs/FindCirc
circRNA_finder           /home/circrna/miniconda3/envs/circRNA_finder
```

## Step 2. Prepare align index, reference file and config file

For running the pipeline, many files are required.

1. Prepare genome fasta file and gtf file. We use `GRCh38.primary_assembly.genome.fa` and `gencode.v34.annotation.gtf`.
1. For Circexplorer2, you need to download the reference file `hg38_ref_all.txt` (should be corresponding to your reference genome) with `fetch_ucsc.py` script from the `Circexplorer2` environment.
1. Prepare align index, [config_zhou.sh](config_zhou.sh) has recorded the commands.
Please note, you need to activate corresponding environment before run index commands.

    For example, to prepare index for CIRIquant.
    ```sh
    source activate CIRIquant
    bwa index -a bwtsw -p /path/to/GRCh38.primary_assembly.genome.fa /path/to/GRCh38.primary_assembly.genome.fa
    hisat2-build -p 40 /path/to/GRCh38.primary_assembly.genome.fa /path/to/GRCh38.primary_assembly.genome.fa
    ```
1. For CIRIquant, a `yml` file is required to set the paths of softwares and files, e.g., [hg38.yml](CIRIquant/hg38.yml). You need to modify the contents to fit your setting (You can also create another `yml` file).
1. Set a `config.sh` file, it sets all required setting with SHELL variables, [config_zhou.sh](config_zhou.sh) is a good reference (Of cource, you can modify its contents to fit your needs).

## Step 3. Preprocess pair-end fastq files

You need preprocess your pair-end fastq files (QC, cut adapters...). [fastp](https://github.com/OpenGene/fastp) is a one-stop solution for this.

Currently, we only support file names with postfix `_1.fastq.gz` and `_2.fastq.gz`.
Please make sure you output your processed fastq files in such format.

## Step 4. Test and run pipeline

Create a shell script with following settings and commands.

```sh
fqfile=./sample_list.txt
indir=/path/include/paired/fastq/files
oudir=/path/to/output
nthreads=20
config=/path/to/your/config.sh

common/ll_fq.py ${indir} --output ${fqfile}

nohup bash caller.sh ${fqfile} ${indir} ${oudir} ${nthreads} ${config} &> run.log &
```

> The script has to be executed in conda `base` environment (or `python3` is installed).
> If you have prepared the `sample_list.txt` file by your own.
> You can comment the `common/ll_fq.py` row, and you can run the script
> in bash without any other requirement (e.g., no python3 is required from the `base` environment).

The directory [run_batch](run_batch/) have examples for running our TCCIA cohorts.

I recommend you testing the pipeline with 4 samples. If it goes well, run the whole data files
you have. The pipeline will skip samples with result file generated.


## Output

The output directory contains result files with names combined from sample names and
methods.

```sh
$ ls *.bed
GO28753_ngs_rna_targrna_rnaaccess_EA_0f0fda909f_20150820.circexplorer2.bed
GO28753_ngs_rna_targrna_rnaaccess_EA_0f0fda909f_20150820.circRNA_finder.bed
GO28753_ngs_rna_targrna_rnaaccess_EA_0f0fda909f_20150820.CIRI.bed
GO28753_ngs_rna_targrna_rnaaccess_EA_0f0fda909f_20150820.find_circ.bed
```

The result file usually contains the postion and count value of circRNAs.

```sh
$ head GO28753_ngs_rna_targrna_rnaaccess_EA_0f0fda909f_20150820.circexplorer2.bed
chr3    9750944 9751949 +       31
chr3    11331339        11348035        +       16
chr3    12489783        12489989        +       19
chr3    12496517        12503784        +       1
chr3    15016151        15034809        +       11
chr3    15210801        15212212        +       12
chr3    15232518        15233973        +       1
chr3    15563357        15573242        -       3
chr3    17372074        17384015        -       2
chr3    18415110        18420991        -       9
```

## Reference

We would like to thank all contributors of the following two projects. Our pipeline
was inspired by the two works and could not be built without them.

- https://github.com/Yelab2020/ICBcircSig
- https://github.com/nf-core/circrna

## Copyright

&copy; 2023 - TCCIA team by Shixiang Wang, Yi Xiong, and Jian-Guo Zhou.