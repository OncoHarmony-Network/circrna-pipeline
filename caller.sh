#!/usr/bin/env bash
# This script serves as a universe caller for 
# running circRNA detection with four approaches.

# https://github.com/shenwei356/rush
rush=/home/circrna/bin/rush
#!/usr/bin/env bash

# Get the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set circRNA callers
CIRIquant=${DIR}/CIRIquant/CIRIquant.sh
FindCirc=${DIR}/FindCirc/FindCirc.sh
Circexplorer2=${DIR}/Circexplorer2/Circexplorer2.sh
circRNA_finder=${DIR}/circRNA_finder/circRNA_finder.sh

if [ ! -f ${CIRCexplorer2} ]; then
    echo "Error: script ${CIRCexplorer2} not found"
    exit 1
fi

if [ ! -f ${CIRIquant} ]; then
    echo "Error: script ${CIRIquant} not found"
    exit 1
fi

if [ ! -f ${FindCirc} ]; then
    echo "Error: script ${FindCirc} not found"
    exit 1
fi

if [ ! -f ${circRNA_finder} ]; then
    echo "Error: script ${circRNA_finder} not found"
    exit 1
fi

# Set paths to other programs
# https://github.com/OpenGene/fastp
fp=/home/circrna/miniconda3/bin/fastp

# Set input and output
sample=go28915_ngs_rna_wts_rnaaccess_EA_5354d4ff11_20170520
indir=/home/data/EGA/OAK/raw
oudir=/home/data/circ_test
nbatch=4
nthreads=20

fqfile=/home/data/EGA/OAK/code/OAK_RNA.txt

# Set commands
# TODO: set QC with fastp

commands="
bash ${CIRIquant} {} ${indir} ${oudir} ${nthreads};
bash ${FindCirc} {} ${indir} ${oudir} ${nthreads};
bash ${Circexplorer2} {} ${indir} ${oudir} ${nthreads};
bash ${circRNA_finder} {} ${indir} ${oudir} ${nthreads};
"

# Run commands in batch
cat $fqfile | head -n 4 | ${rush} ${commands} -j ${nbatch} -k
