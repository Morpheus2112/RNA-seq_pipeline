#!/bin/bash
#BSUB -J "load_data"
#BSUB -R "rusage[mem=4000]"
#BSUB -n 4
#BSUB -W 8:00

module load gdc sqlite3/3.11 
module load gcc/4.8.2 gdc bwa/0.7.12 sambamba/0.6.1 perl/5.18.4 samtools/1.3 hdf5/1.8.12 kallisto/0.43.0 transdecoder/5.3.0
source /cluster/apps/gdc/perl5/etc/bashrc

TRINOTATE_HOME=/cluster/home/zhangjic/Trinotate-Trinotate-v3.1.1/


cp ./../../trinotate_template/Trinotate.sqlite .

$TRINOTATE_HOME/Trinotate Trinotate.sqlite init --gene_trans_map ./../trinity/trinity/Trinity.fasta.gene_trans_map --transcript_fasta ./../trinity/trinity/Trinity.fasta  --transdecoder_pep ./../transcoder/Trinity.fasta.transdecoder.pep

$TRINOTATE_HOME/Trinotate Trinotate.sqlite LOAD_swissprot_blastp ./../diamond_annot/pep.xml	
$TRINOTATE_HOME/Trinotate Trinotate.sqlite LOAD_swissprot_blastx ./../diamond_annot/nuc.xml	

$TRINOTATE_HOME/Trinotate Trinotate.sqlite LOAD_pfam ./../diamond_annot/TrinotatePFAM.out
$TRINOTATE_HOME/Trinotate Trinotate.sqlite LOAD_custom_blast --outfmt6 ./../trembl_annot/pep_trembl.xml --prog blastp --dbtype /cluster/project/gdc/people/zhangjic/diamond_db/trembl

$TRINOTATE_HOME/Trinotate Trinotate.sqlite LOAD_custom_blast --outfmt6 ./../trembl_annot/nuc_trembl.xml --prog blastx --dbtype /cluster/project/gdc/people/zhangjic/diamond_db/trembl



#############export ################

$TRINOTATE_HOME/Trinotate Trinotate.sqlite report  > trinotate_annotation_report.xls



