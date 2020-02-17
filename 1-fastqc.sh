#!/bin/bash
#BSUB -J "fastqc"
#BSUB -R "rusage[mem=2000]"
#BSUB -n 2
#BSUB -W 1:00

module load gcc/4.8.2 gdc java/1.8.0_73 fastqc/0.11.4

DATA=/cluster/project/gdc/people/zhangjic/project_brassica/raw_data/NovaSeq_20191104_NOV226_o6098


ls $DATA/*gz | while read id ; do fastqc $id;done 
