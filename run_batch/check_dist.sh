#!/usr/bin/env bash

cat /home/zhou/raid/CIRC_PIPE_RESULTS/EGA_POPLAR/*.bed | cut -f 1 | sort | uniq -c