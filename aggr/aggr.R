library(data.table)

WorkDir = "test"
GTF = "/home/data/reference/hg38_ek12/gencode.v34.annotation.gtf"
commonPy = "/home/circrna/circrna-pipeline/common/common.py"

stopifnot(file.exists(commonPy), file.exists(GTF), dir.exists(WorkDir))

message("Reading GTF annotation data...")
gtf_data = fread(GTF, header = FALSE, sep = "\t", na.strings = c(".", "NA"))
gtf_data = gtf_data[V3 == "gene"]

message("Extracting gene and region information")
# 提取gene_id和symbol信息
# 一般来说，GTF文件的attributes列是以"; "分隔的键值对，我们可以利用这个信息提取gene_id和symbol
# 这里假设gene_id和gene_symbol都是以"gene_id"和"gene_name"的形式出现在attributes列中
gtf_data[, c("gene_id", "symbol") := {
  attrs <- tstrsplit(V9, "; ")
  gene_id <- gsub('"', '', attrs[grep("^gene_id", attrs)])
  symbol <- gsub('"', '', attrs[grep("^gene_name", attrs)])
  list(gene_id = gene_id, symbol = symbol)
}, by = 1:nrow(gtf_data)]

gtf_data = unique(gtf_data[, list(chr = V1, start = V4, end = V5, strand = V7, gene_id = substr(sub("gene_id ", "", gene_id), 1, 15), symbol = sub("gene_name ", "", symbol))])

# 输出前几行结果
message("Checking gtf data...")
print(head(gtf_data))


message("Scanning result bed files and extracting sample IDs...")
methods = c("circexplorer2", "circRNA_finder", "CIRI", "find_circ")
fileList = list.files(WorkDir, pattern = ".bed")
fileListAll = list.files(WorkDir, pattern = ".bed", full.names = TRUE)
fileList = fileList[file.info(fileListAll)$size > 0]

# 去除 .bed 后缀
sample_ids <- gsub("\\.bed$", "", fileList)

# 使用gsub函数去掉指定的后缀
for (suffix in suffixes_to_remove) {
  sample_ids <- gsub(paste0("\\.", suffix, "$"), "", sample_ids)
}

sample_ids = unique(sample_ids)


read_circRNA_beds = function(in.dir, sample, methods) {
  bed_files = file.path(in.dir, paste0(sample, ".", methods, ".bed"))
  nonexists = !file.exists(bed_files)
  len_nonexists = sum(nonexists)
  if (len_nonexists > 0) {
    warning(len_nonexists, " result file(s) doesn't exist for sample ", sample)
    cat(sample, "\t", len_nonexists, "\n", file = "non_exist_results.report.txt", append = TRUE)
  }
  if (sum(!nonexists) > 1) {
    # Get common regions
    cmd = paste("cat", paste(bed_files[!nonexists], collapse = " "), "|", commonPy, ">", paste0(sample, ".common.bed"))
    system(cmd)
    bed_common = fread(paste0(sample, ".common.bed"), header = FALSE, sep = "\t")

    # Read all files and filter them
    bed_list = lapply(methods[!nonexists], function(x) {
      if (x == "CIRI") {
        d = fread(file.path(in.dir, paste0(sample, ".", x, ".bed")), select = c(1:4, 7), header = FALSE, sep = "\t")
      } else {
        d = fread(file.path(in.dir, paste0(sample, ".", x, ".bed")), select = 1:5, header = FALSE, sep = "\t")
      }

      d$tool = x
      d
    })
    bed_dt = rbindlist(bed_list, use.names = FALSE)
    colnames(bed_dt) = c("chr", "start", "end", "strand", "count", "tool")
    colnames(bed_common) = c("chr", "start", "end")
    bed_dt[, id := paste(chr, start, end, sep = "-")]
    bed_common[, id := paste(chr, start, end, sep = "-")]
    bed_dt2 = bed_dt[id %in% bed_common$id]


  }
}


# Final output
#id, symbol, strand, chrom, startUpBSE, endDownBSE, tool, samples...
#id: symbol:strand:chrom:startUpBSE:endDownBSE

# $ head /home/data/IO_RNA/circRNA/EGA_OAK/go28915_ngs_rna_wts_rnaaccess_EA_0c549080fd_20170512.circexplorer2.bed
# chr3    349358  366115  +       1
# chr3    4410864 4420146 -       2
# chr3    9424466 9435906 +       1
# chr3    9453738 9475156 +       1
# chr3    9762913 9763213 -       1
# chr3    11358417        11380052        +       1
# chr3    11807832        11809682        -       1

# $ head /home/data/IO_RNA/circRNA/EGA_OAK/go28915_ngs_rna_wts_rnaaccess_EA_0c549080fd_20170512.circRNA_finder.bed
# chr6    32519369        32580856        -       203
# KI270711.1      20006   25239   -       43
# chr1    16564806        16567351        -       33
# chr1    247155565       247159813       -       19

# head /home/data/IO_RNA/circRNA/EGA_OAK/go28915_ngs_rna_wts_rnaaccess_EA_0c549080fd_20170512.CIRI.bed
# chr1    1804418 1817875 -       ENSG00000078369.18      GNB1    3
# chr1    1804418 1839238 -       ENSG00000078369.18      GNB1    1

# $ head /home/data/IO_RNA/circRNA/EGA_OAK/go28915_ngs_rna_wts_rnaaccess_EA_0c549080fd_20170512.find_circ.bed
# chr2    232806490       232819985       +       2       circ_000002
# chr1    225519250       225519322       -       1       circ_000003

