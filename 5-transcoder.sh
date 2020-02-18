#!/bin/bash
#BSUB -J "transdecoder"
#BSUB -R "rusage[mem=4000]"
#BSUB -n 4
#BSUB -W 24:00
#BSUB -R "rusage[scratch=20000]"

################### in total 186870 reads ########################

module load gcc/4.8.2 gdc bwa/0.7.12 sambamba/0.6.1 perl/5.18.4 samtools/1.3 hdf5/1.8.12 kallisto/0.43.0 transdecoder/5.3.0
source /cluster/apps/gdc/perl5/etc/bashrc

#use loose criteria
TransDecoder.LongOrfs -m 50 -t  ./../trinity/trinity/Trinity.fasta
TransDecoder.Predict -t  ./../trinity/trinity/Trinity.fasta

# grep ">" *pep | wc -l
# 153669
