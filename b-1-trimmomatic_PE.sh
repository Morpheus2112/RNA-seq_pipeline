########trimmomatic; default parameters!!!!; Niklaus Zemp; GDC;niklaus.zemp@env.ethz.ch
##updated 27.03.18

#!/bin/bash
#BSUB -J "trimPE[1-8]%20"
#BSUB -R "rusage[mem=5000]"
#BSUB -n 2
#BSUB -W 4:00

data="/cluster/project/gdc/people/zhangjic/Solidago_diploid/"

#ls ${data}*_R1.fastq.gz |sed 's/_R1.fastq.gz//' | xargs -L 1 basename  > list.txt

module load gcc/4.8.2 gdc java/1.8.0_73 trimmomatic/0.35
OMP_NUM_THREADS=2
mkdir logs
adapter=/cluster/apps/gdc/trimmomatic/0.35/adapters/TruSeq3-PE.fa
##TruSeq3-PE.fa
##TruSeq3-PE-2.fa
##NexteraPE-PE.fa
##TruSeq3-SE.fa
##TruSeq2-SE.fa
##TruSeq2-PE.fa

IDX=$LSB_JOBINDEX
base=`sed -n ${IDX}p <list.txt`

#trimmomatic SE -threads 2 -phred33 ${data}${base}_R1.fastq.gz ${base}.trim.fq ILLUMINACLIP:${adapter}:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50

trimmomatic PE -threads 2 -phred33 ${data}${base}_R1.fastq.gz ${data}${base}_R2.fastq.gz ${base}.R1.trim.fq.gz ./logs/${base}.R1.un.fq.gz ${base}.R2.trim.fq.gz ./logs/${base}.R2.un.fq.gz ILLUMINACLIP:${adaptor}:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50 > ./logs/${base}.trimmo.log  2> ./logs/${base}.trimmo.err



# fastqc again


#!/bin/bash
#BSUB -J "fastqc"
#BSUB -R "rusage[mem=4000]"
#BSUB -n 2
#BSUB -W 4:00

module load gcc/4.8.2 gdc java/1.8.0_73 fastqc/0.11.4

ls *gz | while read id ; do fastqc $id;done 

multiqc ./