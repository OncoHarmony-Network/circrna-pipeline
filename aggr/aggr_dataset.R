#!/usr/bin/env Rscript
# Example: ./aggr/aggr_dataset.R test2 test2 run_batch_from_qc/EGA_IMmotion151/EGA_IMmotion151.txt

library(data.table)

args = commandArgs(trailingOnly = TRUE)
stopifnot(length(args) > 0)
if (length(args) == 2) {
  InDir = args[1]
  OutDir = args[2]
  AllSampleList = NULL
} else {
  InDir = args[1]
  OutDir = args[2]
  AllSampleList = args[3]
}

stopifnot(dir.exists(InDir))
if (!is.null(AllSampleList)) {
    stopifnot(file.exists(AllSampleList))
}

if (!dir.exists(OutDir)) {
  dir.create(OutDir, recursive = TRUE)
}

message("Scanning result aggr files...")
fileList = list.files(InDir, pattern = "aggr.txt")
fileListAll = list.files(InDir, pattern = "aggr.txt", full.names = TRUE)
f_size = file.info(fileListAll)$size > 0
fileList = fileList[f_size]
fileListAll = fileListAll[f_size]

sample_ids <- unique(gsub("\\.aggr\\.txt$", "", fileList))
stopifnot(length(sample_ids) > 0)

if (!is.null(AllSampleList)) {
    message("Checking if all sample result data files could be found...")
    all_df = fread(AllSampleList, header = FALSE, sep = "\t", na.strings = c(".", "NA"))
    diff_samples = setdiff(all_df[[1]], sample_ids)
    if (length(diff_samples) > 0) {
        message("  No. Print all non-detectable samples...")
        print(diff_samples)
    }
}

message("Merging result aggr files...")
AllData = lapply(fileListAll, fread)
AllData = rbindlist(AllData)
AllData[, id := paste(symbol, strand, chr, start, end, sep = ":")]
AllData[, tool := "four_methods"]  # 多样本聚合没法保留单样本的方法，不然聚合会有问题
AllData = dcast(AllData, id + symbol + strand + chr + start + end + tool ~ sample, value.var = "count", fill = 0)
colnames(AllData)[1:7] = c("id", "symbol", "strand", "chrom", "startUpBSE", "endDownBSE", "tool")

# Final output
#id, symbol, strand, chrom, startUpBSE, endDownBSE, tool, samples...
#id: symbol:strand:chrom:startUpBSE:endDownBSE

# 当有参考的全部样本列表时，对没有检测到的样本全部用 0 填充
if (!is.null(AllSampleList)) {
    if (length(diff_samples) > 0) {
        message("Filling non-detectable samples with 0...")
        AllData[, (diff_samples) := 0]
    }
}

message("Outputing")
out_path = file.path(OutDir, paste0(basename(InDir), "_circRNA.tsv.gz"))
fwrite(x = AllData, file = out_path, sep = "\t")
message("Done. Check ", out_path)
