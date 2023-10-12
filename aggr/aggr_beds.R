#!/usr/bin/env Rscript
# Example: ./aggr/aggr_beds.R /home/data/IO_RNA/circRNA/EGA_IMmotion151 test2

library(data.table)

args = commandArgs(trailingOnly = TRUE)
stopifnot(length(args) > 0)
if (length(args) == 1) {
  InDir = OutDir = args[1]
} else {
  InDir = args[1]
  OutDir = args[2]
}

GTF = if (file.exists("/home/data/reference/hg38_ek12/gencode.v34.annotation.gtf")) {
  "/home/data/reference/hg38_ek12/gencode.v34.annotation.gtf"
} else "/home/zhou/t12b/reference/hg38_ek12/gencode.v34.annotation.gtf"

commonPy = "/home/circrna/circrna-pipeline/common/common.py"

stopifnot(file.exists(commonPy), file.exists(GTF), dir.exists(InDir))
if (!dir.exists(OutDir)) {
  dir.create(OutDir, recursive = TRUE)
}

message("Reading GTF annotation data...")
gtf_data = fread(GTF, header = FALSE, sep = "\t", na.strings = c(".", "NA"))
gtf_data = gtf_data[V3 == "gene"]

message("Extracting gene and region information...")
# 提取gene_id和symbol信息
# 一般来说，GTF文件的attributes列是以"; "分隔的键值对，我们可以利用这个信息提取gene_id和symbol
# 这里假设gene_id和gene_symbol都是以"gene_id"和"gene_name"的形式出现在attributes列中
gtf_data[, c("gene_id", "symbol") := {
  attrs <- tstrsplit(V9, "; ")
  gene_id <- gsub('"', '', attrs[grep("^gene_id", attrs)])
  symbol <- gsub('"', '', attrs[grep("^gene_name", attrs)])
  list(gene_id = gene_id, symbol = symbol)
}, by = 1:nrow(gtf_data)]

gtf_data = unique(gtf_data[, list(chr = V1, start = V4, end = V5, gene_id = substr(sub("gene_id ", "", gene_id), 1, 15), symbol = sub("gene_name ", "", symbol))])

# 输出前几行结果
message("Checking gtf data...")
print(head(gtf_data))

message("Scanning result bed files and extracting sample IDs...")
methods = c("circexplorer2", "circRNA_finder", "CIRI", "find_circ")
fileList = list.files(InDir, pattern = paste0(paste0("(", paste(methods, collapse = ")|("), ")"), ".bed"))
fileListAll = list.files(InDir, pattern = ".bed", full.names = TRUE)
fileList = fileList[file.info(fileListAll)$size > 0]

# 去除 .bed 后缀
sample_ids <- gsub("\\.bed$", "", fileList)

# 使用gsub函数去掉指定的后缀
for (suffix in methods) {
  sample_ids <- gsub(paste0("\\.", suffix, "$"), "", sample_ids)
}

sample_ids = unique(sample_ids)
stopifnot(length(sample_ids) > 0)
message(length(sample_ids), " sample(s) detected")

# Functions ------------------------------------------
overlaps <- function(x, y) {
  ## Overlaps genome regions from x and y
  if (!is.data.frame(x)) {
    stop("x must be a data.frame")
  }
  if (!is.data.frame(y)) {
    stop("y must be a data.frame")
  }

  x <- data.table::as.data.table(x)
  y <- data.table::as.data.table(y)

  colnames(x)[1:3] <- colnames(y)[1:3] <- c("chr", "start", "end")

  data.table::setkey(y, chr, start, end)
  out <- data.table::foverlaps(x, y)[!is.na(start)]
  out
}

aggr_circRNA_beds = function(sample, methods) {
  bed_files = file.path(InDir, paste0(sample, ".", methods, ".bed"))
  nonexists = !file.exists(bed_files)
  len_nonexists = sum(nonexists)
  if (len_nonexists > 0) {
    warning(len_nonexists, " result bed file(s) doesn't exist for sample ", sample, immediate. = TRUE)
    cat(sample, "\t", len_nonexists, "\n", file = file.path(OutDir, "non_exist_results.report.txt"), append = TRUE)
  }
  if (sum(!nonexists) > 1) {
    # Get common regions
    cmd = paste("cat", paste(bed_files[!nonexists], collapse = " "), "|", commonPy, ">", file.path(OutDir, paste0(sample, ".common.txt")))
    system(cmd)
    bed_common = fread(file.path(OutDir, paste0(sample, ".common.txt")), header = FALSE, sep = "\t")
    file.remove(file.path(OutDir, paste0(sample, ".common.txt")))  # Remove temp common file

    # Read all files and filter them
    bed_list = parallel::mclapply(methods[!nonexists], function(x) {
      if (x == "CIRI") {
        d = fread(file.path(InDir, paste0(sample, ".", x, ".bed")), select = c(1:4, 7), header = FALSE, sep = "\t")
      } else {
        d = fread(file.path(InDir, paste0(sample, ".", x, ".bed")), select = 1:5, header = FALSE, sep = "\t")
      }

      if (nrow(d) == 0) {
        warning(sprintf("void data detected for %s with method %s", sample, x), immediate. = TRUE)
        return(d)
      }

      d$tool = x
      d
    }, mc.cores = getOption("mc.cores", 4L))
    bed_dt = rbindlist(bed_list, use.names = FALSE)
    colnames(bed_dt) = c("chr", "start", "end", "strand", "count", "tool")

    # 增加样本水平 circRNA ID 的输出
    # 方便后续分析不同方法的 overlap 以及统计总量
    bed_dt_o = copy(bed_dt)
    bed_dt_o$sample = sample
    fwrite(x = bed_dt_o, file = file_to_all, sep = "\t", append = TRUE)

    # 获取和分析 common circRNA
    if (nrow(bed_common) == 0) {
      warning("no common circRNA detected for sample ", sample, immediate. = TRUE)
      return(invisible(NULL))
    }
    colnames(bed_common) = c("chr", "start", "end")
    bed_common = bed_common[chr %in% paste0("chr", c(1:22, "X", "Y"))]
    if (nrow(bed_common) == 0) {
      warning("no common circRNA detected for sample in chr 1-22,X,Y", sample, immediate. = TRUE)
      return(invisible(NULL))
    }

    bed_dt[, id := paste(chr, start, end, sep = "-")]
    bed_common[, id := paste(chr, start, end, sep = "-")]

    annot = unique(overlaps(bed_common, gtf_data)[
      , .(id, gene_id, symbol, ovp_len = fcase(
        i.start <= start, i.end - start + 1,
        i.end >= end, end - i.start + 1,
        i.start > start, i.end - i.start + 1
      ))])
    # Only keep symbol, as gene_id is not required in downstream
    # 仅标记最大 overlap 的基因
    annot = annot[ , list(symbol = symbol[which.max(ovp_len)]), by = .(id)]
    # Some may have no annotation on gene, such cases will not be kept
    #"chr4-42725521-42744676"

    # Final output for one sample
    bed_dt2 = merge(bed_dt, annot, by = "id", all.x = FALSE, all.y = TRUE)
    solid_ids = bed_dt2[, .(N = sum(count >= 2)), by = .(id)][N >= 1]$id  # id by at least two tools with ≥1 back-splice reads
    
    if (length(solid_ids) > 0) {
      message("\t=>", length(solid_ids), " solid circRNAs detected")
      bed_dt2 = bed_dt2[id %in% solid_ids]
      bed_dt2$id = NULL
      rv = bed_dt2[, .(tool = paste(tool, collapse = ","),
                  count = mean(count, na.rm=TRUE)), 
                  by = .(chr, start, end, strand, symbol)]  # Get average count
      rv$sample = sample
      fwrite(x = rv, file = file.path(OutDir, paste0(sample, ".aggr.txt")), sep = "\t")
    } else {
      warning("no solid circRNA detected for sample ", sample, immediate. = TRUE)
    }
  } else {
    warning("no solid circRNA detected for sample ", sample, immediate. = TRUE)
  }
}

# Processing in batch

message("Reading, joining & annotating circRNAs...")

file_to_all = file.path(OutDir, paste0(basename(InDir), ".circRNA_all.txt"))
if (file.exists(file_to_all)) invisible(file.remove(file_to_all))

invisible(
  parallel::mclapply(sample_ids, function(sample) {
  message("\thandling ", sample)
  aggr_circRNA_beds(sample, methods)
}, mc.cores = min(parallel::detectCores(), 20L))
)

# for (sample in sample_ids) {
#   message("\thandling ", sample)
#   aggr_circRNA_beds(sample, methods)
# }

message("Done. Please check result *.aggr.txt in ", OutDir)


