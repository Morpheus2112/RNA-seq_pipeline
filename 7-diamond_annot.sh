#!/bin/bash

#BSUB -J "dimond_blast"
#BSUB -W 24:00
#BSUB -n 8
#BSUB -R "rusage[mem=5000]"


module load gdc
module load diamond/0.9.3 hmmer/3.1 blast/2.3.0

diamond blastp -d ./../../swiss -q  ./../transcoder/Trinity.fasta.transdecoder.pep --salltitles -p 24  --sensitive --top 1 -e 1e-5 --block-size 25 -f 6 --out pep.xml > pep.log 2> pep.log.err
diamond blastx -d ./../../swiss -q  ./../trinity/trinity/Trinity.fasta --salltitles -p 24  --sensitive --top 1 -e 1e-5 --block-size 25 -f 6 --out nuc.xml > nuc.log 2> nuc.log.err
hmmscan --cpu 24 --domtblout TrinotatePFAM.out ./../../Pfam-A.hmm ./../transcoder/Trinity.fasta.transdecoder.pep > pfam.log
