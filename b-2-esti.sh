
#################################### Trinity transcripts estimation ################################
#!/bin/bash
#BSUB -J "transcripts_esti"
#BSUB -R "rusage[mem=4000]"
#BSUB -n 8
#BSUB -W 4:00
#BSUB -R "rusage[scratch=20000]"

module load gdc trinity/2.8.4 
module load gcc/4.8.2 gdc hdf5/1.8.12 kallisto/0.45.0

#ls -d ./../trimmed/*fq > sample3.txt 
#paste ./../trinity/samples1.txt ./../trinity/samples2.txt sample3.txt > samples

$TRINITY_HOME/util/align_and_estimate_abundance.pl  --transcripts ./../trinity/trinity/Trinity.fasta --seqType fq --samples_file samples --est_method kallisto --trinity_mode --output_dir kallisto_outdir_offline --thread_count 8



#############################     matrix estimation ###########################################

find -name abundance.tsv > files.txt

$TRINITY_HOME/util/abundance_estimates_to_matrix.pl --est_method kallisto \
    --gene_trans_map ./../trinity/trinity/Trinity.fasta.gene_trans_map \
    --out_prefix kallisto \
    --quant_files files.txt \
    --name_sample_by_basedir 
