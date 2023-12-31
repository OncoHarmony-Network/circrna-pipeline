#!/usr/bin/env python3
# cat test/*.bed | ./common.py -t 1
import argparse
import sys
from collections import defaultdict

def parse_bed_entry(line):
    chromosome, start, end = line.strip().split('\t')[:3]
    return (chromosome, int(start), int(end))

def find_common_entries(bed_entries, deviation=3, count_threshold=2):
    bed_entries_dict = defaultdict(int)
    common_entries = []
    
    for entry in bed_entries:

        if len(bed_entries_dict) == 0:
            bed_entries_dict[entry] += 1
        else:
            flag = []
            for other_entry, count in bed_entries_dict.items():
                if entry[0] == other_entry[0] and \
                    abs(entry[1] - other_entry[1]) <= deviation and abs(entry[2] - other_entry[2]) <= deviation:
                    bed_entries_dict[other_entry] += 1
                    flag.append(True)
                else:
                    flag.append(False)
            if not any(flag):
                bed_entries_dict[entry] += 1
    
    for entry, count in bed_entries_dict.items():
        if bed_entries_dict[entry] >= count_threshold:
            common_entries.append(entry)
    
    return common_entries

def main():
    parser = argparse.ArgumentParser(description='Find common entries in BED input.')
    parser.add_argument('bed_file', nargs='?', help='Input BED file. If not provided, input will be read from stdin.')
    parser.add_argument('-d', '--deviation', type=int, default=0, help='Deviation value (default: 0)')
    parser.add_argument('-t', '--count-threshold', type=int, default=2, help='Count threshold value (default: 2)')
    args = parser.parse_args()
    
    bed_entries = []
    if args.bed_file:
        with open(args.bed_file, 'r') as file:
            for line in file:
                entry = parse_bed_entry(line)
                bed_entries.append(entry)
    else:
        for line in sys.stdin:
            entry = parse_bed_entry(line)
            bed_entries.append(entry)
    
    common_entries = find_common_entries(bed_entries, args.deviation, args.count_threshold)
    
    for entry in common_entries:
        print('\t'.join(map(str, entry)))

if __name__ == '__main__':
    main()
