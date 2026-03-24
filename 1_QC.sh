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

#Importing and activating  Conda Environment
source $HOME/.bash_profile
conda activate tbrucei

#creates and sets output directory 
mkdir ../qc/
#moves into qc directory and makes blood directory
cd qc
mkdir ../blood/

#makes sample name for arrays
SAMPLE="Blood"$SLURM_ARRAY_TASK_ID

#creates FASTQ file names
FASTQ=${SAMPLE}.fastq.gz

#sets input
#replace XXX with filepath to the fastq files
INDIR=XXX
#sets output
OUTDIR=../qc/blood/

# Running QC Analysis
fastqc \
 -t 8 \
 --fastq "$FASTQ" \
 -o "$OUTDIR"

cd ../qc #Moves back to qc directory
mkdir ../csf #Creates output directory

SAMPLE="CSF"$SLURM_ARRAY_TASK_ID #Makes smaple name for arrays
FASTQ=${SAMPLE}.fastq.gz #Creates FASTQ file names
OUTDIR=../qc/csf/ #Sets output

#sets input
#replace XXX with filepath to the fastq files
INDIR=XXX

# Running QC Analysis
fastqc \
 -t 8 \
 --fastq "$FASTQ" \
 -o "$OUTDIR"

# Deactivate Conda
conda deactivate


