#!/bin/bash


module load gcc/4.8.2 gdc bowtie2/2.3.2 python/2.7.11 perl/5.18.4 java/1.8.0_101 samtools/1.9 jellyfish/2.2.10 boost/1.55.0 trinity/2.8.4
export PATH=/cluster/project/gdc/shared/tools/salmon/salmon-0.13.1_linux_x86_64/bin:$PATH
source /cluster/apps/gdc/perl5/etc/bashrc



grep '>' trinity/Trinity.fasta | wc -l
# 186870
$TRINITY_HOME/util/TrinityStats.pl trinity/Trinity.fasta  > count_of_transcripts.txt

# ################################
# ## Counts of transcripts, etc.
# ################################
# Total trinity 'genes':  83962
# Total trinity transcripts:      186870
# Percent GC: 43.37

# ########################################
# Stats based on ALL transcript contigs:
# ########################################

#         Contig N10: 3156
#         Contig N20: 2365
#         Contig N30: 1931
#         Contig N40: 1627
#         Contig N50: 1367

#         Median contig length: 585
#         Average contig: 886.20
#         Total assembled bases: 165604945


# #####################################################
# ## Stats based on ONLY LONGEST ISOFORM per 'GENE':
# #####################################################

#         Contig N10: 3025
#         Contig N20: 2212
#         Contig N30: 1763
#         Contig N40: 1403
#         Contig N50: 1058

#         Median contig length: 362
#         Average contig: 651.57
#         Total assembled bases: 54706768
