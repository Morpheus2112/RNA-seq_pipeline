#!/bin/bash

#BSUB -J "trembl_blast"
#BSUB -W 24:00
#BSUB -n 8
#BSUB -R "rusage[mem=5000]"


module load gdc
module load diamond/0.9.3 hmmer/3.1 blast/2.3.0

diamond blastp -d /cluster/project/gdc/people/zhangjic/diamond_db/trembl -q  ./../transcoder/Trinity.fasta.transdecoder.pep --salltitles -p 24  --sensitive --top 1 -e 1e-5 --block-size 25 -f 6 --out pep_trembl.xml > pep_trembl.log 2> pep_trembl.log.err
diamond blastx -d /cluster/project/gdc/people/zhangjic/diamond_db/trembl -q  ./../trinity/trinity/Trinity.fasta --salltitles -p 24  --sensitive --top 1 -e 1e-5 --block-size 25 -f 6 --out nuc_trembl.xml > nuc_trembl.log 2> nuc_trembl.log.err

# 129953 pep
# 148978 nuc