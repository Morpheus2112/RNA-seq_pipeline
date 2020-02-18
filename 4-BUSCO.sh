#!/bin/bash

#BSUB -J "busco"
#BSUB -W 4:00
#BSUB -n 10
#BSUB -R "rusage[mem=500]"



module load gcc/4.8.2 gdc python/3.4.3 blast/2.3.0 hmmer/3.1 boost/1.55.0 sqlite3/3.11 gsl/1.16 suitesparse/4.5.1 bamtools/2.4.0 augustus/3.2.1 emboss/6.5.7 busco/2.0

 # adjust the path:
 export AUGUSTUS_CONFIG_PATH="/cluster/scratch/zhangjic/BUSCO/local_augustus/config"

 # adjust the options: -i -l -m :
 #   and you could add --long for two rounds of gene predictions
 #   and you could change the species model with e.g. -sp elegans
 BUSCO.py  -c 10 -o Arab_trans  -i ./trinity/Trinity.fasta    -l /cluster/project/gdc/shared/databases/busco/eukaryota_odb9 -sp thaliana -m transcriptome  > busco.log 2> busco.err

#
# Summarized benchmarking in BUSCO notation for file ./trinity/Trinity.fasta
# BUSCO was run in mode: tran

        # C:97.7%[S:13.9%,D:83.8%],F:1.3%,M:1.0%,n:303

        # 296     Complete BUSCOs (C)
        # 42      Complete and single-copy BUSCOs (S)
        # 254     Complete and duplicated BUSCOs (D)
        # 4       Fragmented BUSCOs (F)
        # 3       Missing BUSCOs (M)
        # 303     Total BUSCO groups searched