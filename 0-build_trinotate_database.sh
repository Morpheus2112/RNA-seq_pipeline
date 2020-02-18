#!/bin/bash
#bulid database
TRINOTATE_HOME=/cluster/home/zhangjic/Trinotate-Trinotate-v3.1.1/
$TRINOTATE_HOME/admin/Build_Trinotate_Boilerplate_SQLite_db.pl  Trinotate

#!/bin/bash
#BSUB -J "database_construction"
#BSUB -R "rusage[mem=8000]"
#BSUB -n 8
#BSUB -W 24:00
#BSUB -R "rusage[scratch=20000]"
module load gdc hmmer/3.1 blast/2.3.0

makeblastdb -in uniprot_sprot.pep -dbtype prot
gunzip Pfam-A.hmm.gz
hmmpress Pfam-A.hmm



module load gdc
module load diamond/0.9.3 hmmer/3.1 blast/2.3.0

diamond makedb --in uniprot_sprot.pep -d swiss