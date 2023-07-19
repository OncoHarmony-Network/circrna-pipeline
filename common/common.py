#!/usr/bin/env python3
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
        print("dict:", bed_entries_dict)
        print("entry:", entry)
        positions = set(range(entry[1], entry[2] + 1))
        for other_entry, count in bed_entries_dict.items():
            print("other", other_entry)
            if entry[0] == other_entry[0] and \
               not positions.isdisjoint(range(other_entry[1] - deviation, other_entry[2] + deviation + 1)):
                bed_entries_dict[other_entry] += 1
        bed_entries_dict[entry] += 1
    
                # if bed_entries_dict[other_entry] == count_threshold:
                # common_entries.append(other_entry)
    return common_entries

def main():
    parser = argparse.ArgumentParser(description='Find common entries in BED input.')
    parser.add_argument('bed_file', nargs='?', help='Input BED file. If not provided, input will be read from stdin.')
    parser.add_argument('-d', '--deviation', type=int, default=3, help='Deviation value')
    parser.add_argument('-t', '--count-threshold', type=int, default=2, help='Count threshold value')
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
