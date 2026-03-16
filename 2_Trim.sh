#!/bin/bash
#SBATCH --job-name=trim-galore
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=16g
#SBATCH --time=12:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --array=1-5

source $HOME/.bash_profile #Allows conda use
conda activate tbrucei #Activates conda env

#creates output directories and moves into the blood file
mkdir trimmed
cd trimmed
mkdir blood
mkdir csf
cd ../blood/

SAMPLE="Blood"$SLURM_ARRAY_TASK_ID
FASTQ=${SAMPLE}.fastq.gz #Sets fastq file name
OUT=../trimmed/blood/ #Sets output file
FASTQC=../qc/blood/$SAMPLE"_fastqc.zip" #Sets location of fastqc files

trim_galore $FASTQ \
        --fastqc \
        -o $OUT \
        -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACAGTTCCGTATCTCGTAT \ #Adaptor sequernce revealed by fastqc
        --cores 8 \
        --fastqc $FASTQC #Runs fastqc
#Runs trim_galore
cd ../csf/ #Moves into csf direcotrory

SAMPLE="CSF"$SLURM_ARRAY_TASK_ID
FASTQ=${SAMPLE}.fastq.gz #Sets fastq file name
OUT=../trimmed/csf/ #Sets output file
FASTQC=../qc/csf/$SAMPLE"_fastqc.zip" #Sets location of fastqc files

trim_galore $FASTQ \
        --fastqc \
        -o $OUT \
        -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACAGTTCCGTATCTCGTAT \ #Adaptor sequernce revealed by fastqc
        --cores 8 \
        --fastqc $FASTQC #Runs fastqc

conda deactivate #deactivates conda


