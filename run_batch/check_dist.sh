#!/usr/bin/env bash

cat /home/data/CIRC_PIPE_RESULTS/EGA_OAK/*.bed | cut -f 1 | sort | uniq -c