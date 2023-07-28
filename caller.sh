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
# fp=/home/circrna/miniconda3/bin/fastp

# Set input and output
fqfile=$1
indir=$2
oudir=$3
nthreads=$4
config=$5

if [ -z "$config" ]; then
    echo "config is empty, default is config_zhou2.sh"
    config=${DIR}/config_zhou2.sh
fi

# Set commands
# TODO: set QC with fastp

# commands="
# bash ${CIRIquant} {} ${indir} ${oudir} ${nthreads};
# bash ${FindCirc} {} ${indir} ${oudir} ${nthreads};
# bash ${Circexplorer2} {} ${indir} ${oudir} ${nthreads};
# bash ${circRNA_finder} {} ${indir} ${oudir} ${nthreads};
# "
#cat $fqfile | head -n 4 | ${rush} ${commands} -j ${nbatch} -k

# Run commands in batch
commands="bash {} {sample} ${indir} ${oudir} ${nthreads} ${config}"

for sample in $(cat $fqfile)
do
    #bash ${CIRIquant} ${sample} ${indir} ${oudir} ${nthreads}
    echo "${CIRIquant} ${Circexplorer2} ${circRNA_finder} ${FindCirc}" | ${rush} -D " " -T b -k -j 4 -v sample=${sample} ${commands}
    #echo "${CIRIquant} ${Circexplorer2} ${circRNA_finder} ${FindCirc}" | ${rush} --dry-run -D " " -T b -k -j 4 -v sample=${sample} ${commands}
done

