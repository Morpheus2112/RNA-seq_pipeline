#!/bin/bash
#BSUB -J "Trinity"
#BSUB -R "rusage[mem=12000]"
#BSUB -n 10
#BSUB -W 72:00
#BSUB -R "span[hosts=1]"
#BSUB -R "rusage[scratch=12000]"
module load gcc/4.8.2 gdc bowtie2/2.3.2 python/2.7.11 perl/5.18.4 java/1.8.0_101 samtools/1.9 jellyfish/2.2.10 boost/1.55.0 trinity/2.8.4
export PATH=/cluster/project/gdc/shared/tools/salmon/salmon-0.13.1_linux_x86_64/bin:$PATH
source /cluster/apps/gdc/perl5/etc/bashrc
### unlimit stack size
ulimit -s unlimited

#make samples.txt
DATA=/cluster/project/gdc/people/zhangjic/project_brassica/raw_data/NovaSeq_20191104_NOV226_o6098
ls $DATA/*.gz > samples3.txt 
ls $DATA/*.gz | xargs -L 1 basename | sed 's/20191104.A-//g' | sed 's/_R1.fastq.gz//g' > samples2.txt
cut -f1 -d_ samples2.txt > samples1.txt
paste samples1.txt samples2.txt samples3.txt > samples

##mkdir TEMP not needed since TMPDIR is an predefined variable
### run trinity
Trinity  --seqType fq --samples_file samples --CPU 10 --max_memory 120G \
--normalize_reads \
--SS_lib_type F \
--output trinity \
--trimmomatic   --quality_trimming_params  "ILLUMINACLIP:/cluster/apps/gdc/trinity/2.5.1/trinity-plugins/Trimmomatic/adapters/TruSeq3-SE.fa:2:30:10 SLIDINGWINDOW:4:5 LEADING:5 TRAILING:5 MINLEN:25"

