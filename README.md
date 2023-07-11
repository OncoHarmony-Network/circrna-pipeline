# CircRNA Identification and Integration Pipeline

- NC 参考代码处：https://github.com/Yelab2020/ICBcircSig
- circrna nextflow 参考代码处：https://github.com/nf-core/circrna/tree/master/modules/local
    - ciriquant: https://github.com/nf-core/circrna/blob/master/modules/local/ciriquant/ciriquant/main.nf https://github.com/nf-core/circrna/blob/master/modules/local/ciriquant/filter/main.nf
    - https://github.com/nf-core/circrna/blob/master/modules/local/find_circ/find_circ/main.nf, https://github.com/nf-core/circrna/blob/master/modules/local/find_circ/filter/main.nf, https://github.com/nf-core/circrna/blob/master/modules/local/find_circ/anchors/main.nf

https://github.com/nf-core/circrna/blob/18e580e3f81c3c37189c49033948616a773404af/subworkflows/local/circrna_discovery.nf 这个文件显示了不同软件 workflow 的流程，有参考价值。

zhou2 数据：

```
数据：
/home/data/EGA/OAK/raw
代码
/home/data/EGA/OAK/code
参考基因组
/home/data/reference
/home/data/reference/hg38_ek12

参考文件
hg38_ek12/GRCh38.primary_assembly.genome.fa
hg38_ek12/gencode.v34.annotation.gtf
```

样本列表在 `/home/data/EGA/OAK/code/OAK_RNA.txt`



## Copyright

&copy; 2023 - TCCIA team