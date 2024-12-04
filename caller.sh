#!/usr/bin/env bash
# This script serves as a universe caller for 
# running circRNA detection with four approaches.

# https://github.com/shenwei356/rush
rush=~/bin/rush

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

array1=($(cat $fqfile))
array2=(${CIRIquant} ${Circexplorer2} ${circRNA_finder} ${FindCirc})

# Create an empty array to store the combinations
combinations=()

# Loop through the sample array
for item1 in "${array1[@]}"; do
    # Loop through the method path array
    for item2 in "${array2[@]}"; do
        # Concatenate the two items and add them to the combinations array
        combinations+=("$item1;$item2")
    done
done

echo "CircRNA identification pipeline with 4 callers"
echo "=================================================="
echo "Author: Shixiang Wang (shixiang1994wang@gmail.com)"
echo "Latest update: 2023-10-18"
echo "========================="
echo ""

# Run commands in batch
nthreads_prog=8
njob=$((${nthreads} / ${nthreads_prog}))
if [ $njob -lt 1 ]; then
    njob=1
fi
echo "$nthreads_prog threads sets to each call by default"
echo "$nthreads threads set by user (a multiple of 8 is recommended)"
echo "Number of jobs: $njob"
echo "The pipeline is starting..."

cmds="echo 'starting rush job with setting: {2}, {1}' && bash {2} {1} ${indir} ${oudir} ${nthreads_prog} ${config}"
echo ${combinations[@]} | ${rush} -D " " -d ";" -T b -k -j ${njob} ${cmds}
# 一个已知问题，当circrna_finder并行调用过多时需要内存非常大，star可能出现问题崩溃导致结果为空
# 当发现相关错误时可以合理减少计算资源重跑解决
# for 循环按样本逐个处理可能会更加稳定（计算时间会延长）

echo "The pipeline is done. Please check the result files."
