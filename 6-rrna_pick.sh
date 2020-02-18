#!/bin/bash
#BSUB -J "rRNApick"
#BSUB -R "rusage[mem=5000]"
#BSUB -n 8
#BSUB -W 24:00
#BSUB -R "rusage[scratch=20000]"

module load gcc/4.8.2 gdc perl/5.18.4 ribopicker/0.4.3

ribopicker.pl  -f ./../trinity/trinity/Trinity.fasta -dbs slr108,ssr108 -id Trinity

#grep ">" Trinity_rrna.fa | wc -l
# 1010 rRNA, not very much 