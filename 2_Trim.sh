#!/bin/bash
#SBATCH --job-name=trim-galore
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-node=8
#SBATCH --mem=16g
#SBATCH --time=12:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --array=1-5

#activating conda environment
source $HOME/.bash_profile
conda activate tbrucei

#moves back into home directory
#replace XXX with file path back to home directory
cd XXX
#creates output directories and moves into the blood file
mkdir trimmed
cd trimmed
mkdir blood
mkdir csf
#replace XXX with file path to trimmed directory
cd XXX/trimmed/blood/


SAMPLE="Blood"$SLURM_ARRAY_TASK_ID
FASTQ=${SAMPLE}.fastq.gz #Sets fastq file name

#replace XXX with filepath to this directory
OUT=XXX/trimmed/blood/ #Sets output file
FASTQC=XXX/qc/blood/$SAMPLE"_fastqc.zip" #Sets location of fastqc files

#runs trim galore
trim_galore $FASTQ \
        --fastqc \
        -o $OUT \
#adaptor sequence revealed by fastqc
        -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACAGTTCCGTATCTCGTAT \
        --cores 8 \
        --fastqc $FASTQC #Runs fastq

#moves into trimeed csf directory
#replace XXX with filepath to this directory 
cd XXX/trimmed/csf/


SAMPLE="CSF"$SLURM_ARRAY_TASK_ID
FASTQ=${SAMPLE}.fastq.gz #Sets fastq file name
OUT=../trimmed/csf/ #Sets output file
FASTQC=../qc/csf/$SAMPLE"_fastqc.zip" #Sets location of fastqc files

trim_galore $FASTQ \
        --fastqc \
        -o $OUT \
        -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACAGTTCCGTATCTCGTAT \c
        --cores 8 \
        --fastqc $FASTQC #Runs fastqc

conda deactivate #deactivates conda


