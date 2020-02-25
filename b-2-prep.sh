#!/bin/bash
#BSUB -J "transcripts_prep"
#BSUB -R "rusage[mem=4000]"
#BSUB -n 4
#BSUB -W 4:00

module load gdc trinity/2.8.4 
module load gcc/4.8.2 gdc hdf5/1.8.12 kallisto/0.45.0

$TRINITY_HOME/util/align_and_estimate_abundance.pl  --transcripts ./../trinity/trinity/Trinity.fasta --est_method kallisto --trinity_mode --prep_reference
