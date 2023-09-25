#!/usr/bin/env python3

import os
import re
import argparse
from collections import Counter

def list_fastq_files(directory, output_all, output_uniq):
    # 获取目录下所有文件名
    file_list = os.listdir(directory)

    # 使用正则表达式匹配文件名，去掉后缀_2.fastq.gz或_1.fastq.gz (fq.gz is also supported)
    fastq_files = []
    for file_name in file_list:
        match = re.match(r'(.+)_[fr]?\d.+f*q\.gz$', file_name)
        if match:
            fastq_files.append(match.group(1))

    counter = Counter(fastq_files)

    if output_all:
        return set(fastq_files)
    elif output_uniq:
        uniq_files = [file_name for file_name, count in counter.items() if count == 1]
        return uniq_files
    else:
        filtered_files = [file_name for file_name, count in counter.items() if count == 2]
        return filtered_files

def main():
    parser = argparse.ArgumentParser(description='List fastq.gz files without suffix in the given directory.')
    parser.add_argument('directory', type=str, help='The target directory to search for fastq.gz files.')
    parser.add_argument('--output', '-o', type=str, help='Export the output to a specified file.')
    parser.add_argument('--all', action='store_true', help='Output all file names.')
    parser.add_argument('--uniq', action='store_true', help='Output only the file names with count 1.')

    args = parser.parse_args()
    directory = args.directory
    output_file = args.output
    output_all = args.all
    output_uniq = args.uniq

    if not os.path.isdir(directory):
        print(f"Error: '{directory}' is not a valid directory.")
        return

    fastq_files = list_fastq_files(directory, output_all, output_uniq)

    if len(fastq_files) == 0:
        print("No (or no unique) fastq.gz files found in the directory.")
    else:
        if output_file:
            with open(output_file, 'w') as f:
                for file_name in fastq_files:
                    f.write(file_name + '\n')
        else:
            for file_name in fastq_files:
                print(file_name)

if __name__ == '__main__':
    main()

