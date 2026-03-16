#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=5
#SBATCH --cpus-per-task=1
#SBATCH --mem=64g
#SBATCH --time=10:00:00
#SBATCH --job-name=QC
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXX@nottingham.ac.uk
#SBATCH --array=1-5

# Importing Conda Environment
source $HOME/.bash_profile
conda activate tbrucei2

# Setting fastq file location
cd ./blood

mkdir ../qc/blood/ #Creates output diorectory
 
SAMPLE="Blood"$SLURM_ARRAY_TASK_ID #Makes smaple name for arrays
FASTQ=${SAMPLE}.fastq.gz #Creates FASTQ file names
OUTDIR=../qc/blood/ #Sets output

# Running QC Analysis
fastqc \
 -t 8 \
 --fastq "$FASTQ" \
 -o "$OUTDIR"
#Runs fastqc


# Setting fastq file location
cd ../csf #Moves to csf directory
mkdir ../qc/csf #Creates output directory

SAMPLE="CSF"$SLURM_ARRAY_TASK_ID #Makes smaple name for arrays
FASTQ=${SAMPLE}.fastq.gz #Creates FASTQ file names
OUTDIR=../qc/csf/ #Sets output

# Running QC Analysis
fastqc \
 -t 8 \
 --fastq "$FASTQ" \
 -o "$OUTDIR"
#Runs fastqc

# Deactivate Conda
conda deactivate


