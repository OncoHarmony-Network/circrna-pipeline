#!/bin/bash

# 设置目录路径
directory=$1

# 进入目录
cd "$directory" || exit

# 遍历目录下的所有文件
for file in *.fastq.gz; do
    # 提取文件名和对应的.md5文件名
    filename=$file
    md5file="$filename.md5"
    
    # 使用md5sum计算文件的MD5值
    calculated_md5=$(md5sum "$file" | awk '{print $1}')
    
    # 检查是否存在对应的.md5文件
    if [ -f "$md5file" ]; then
        # 读取.md5文件中保存的MD5值
        expected_md5=$(cat "$md5file" | awk '{print $1}')
        
        # 对比计算的MD5值和预期的MD5值
        if [ "$calculated_md5" = "$expected_md5" ]; then
            echo "文件 $file 的MD5值匹配"
        else
            echo "文件 $file 的MD5值不匹配"
        fi
    else
        echo "找不到对应的.md5文件：$md5file"
    fi
done
