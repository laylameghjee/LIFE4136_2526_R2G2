#!/bin/bash
#SBATCH --job-name=trim-galore
#SBATCH --partition=defq
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

#settind directories 
#replace XXX with file path to home directory
PD=XXX

#creates output directories and moves into the blood file
mkdir -p "$PD"/trimmed/blood
mkdir -p "$PD"/trimmed/csf

cd "$PD"/trimmed/blood

SAMPLE="Blood"$SLURM_ARRAY_TASK_ID
FASTQ=${SAMPLE}.fastq.gz #Sets fastq file name

OUT="$PD"/trimmed/blood/ #Sets output file
FASTQ="$PD/qc/blood/$SAMPLE"_fastqc.zip" #Sets location of fastqc files

#runs trim galore
trim_galore" $FASTQ" \
        --fastqc \
        -o "$OUT" \
#adaptor sequence revealed by fastqc
        -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACAGTTCCGTATCTCGTAT \
        --cores 8 \
        --fastqc" $FASTQ" #Runs fastq

#moves into trimeed csf directory 
cd "$PD"/trimmed/csf/


SAMPLE="CSF"$SLURM_ARRAY_TASK_ID
FASTQ=${SAMPLE}.fastq.gz #Sets fastq file name
OUT="$PD"/trimmed/csf/ #Sets output file
FASTQC=../qc/csf/$SAMPLE"_fastqc.zip" #Sets location of fastqc files

trim_galore" $FASTQC" \
        --fastqc \
        -o "$OUT" \
        -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACAGTTCCGTATCTCGTAT \
        --cores 8 \
        --fastqc" $FASTQC" #Runs fastqc

conda deactivate #deactivates conda


