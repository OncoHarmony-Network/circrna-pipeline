#!/usr/bin/env bash
# This script serves as a universe caller for 
# running circRNA detection with four approaches.

fqfile=/home/data/EGA/OAK/code/OAK_RNA.txt

# https://github.com/shenwei356/rush
rush=/home/circrna/bin/rush
# https://github.com/OpenGene/fastp
fp=/home/circrna/miniconda3/bin/fastp
CIRIquant=./CIRIquant/CIRIquant.sh
FindCirc=./FindCirc/FindCirc.sh


${rush} echo {} -i ${fqfile} -j 4 -k --dry-run

