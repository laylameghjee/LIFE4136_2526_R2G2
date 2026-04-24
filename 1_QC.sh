#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64g
#SBATCH --time=10:00:00
#SBATCH --job-name=QC
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXX@nottingham.ac.uk
#SBATCH --array=1-5

#Importing and activating  Conda Environment
source $HOME/.bash_profile
conda activate tbrucei

#sets input  directory
#replace XXX with filepath to the fastq files
INDIR=XXX
cd "$INDIR"

#creates and sets output directory 
mkdir -p ../qc/blood
mkdir -p ../qc/csf

#makes sample name for arrays
SAMPLE="Blood"$SLURM_ARRAY_TASK_ID

#creates FASTQ file names
FASTQ=${INDIR}/${SAMPLE}.fastq.gz

#sets output
OUTDIR=../qc/blood

# Running QC Analysis
fastqc \
 -t 8 \
 --fastq "$FASTQ" \
 -o "$OUTDIR"


#makes sample name for arrays
SAMPLE="CSF"$SLURM_ARRAY_TASK_ID

#creates FASTQ file names
FASTQ=${INDIR}/${SAMPLE}.fastq.gz 

#sets output
OUTDIR=../qc/csf

# Running QC Analysis
fastqc \
 -t 8 \
 --fastq "$FASTQ" \
 -o "$OUTDIR"

# Deactivate Conda
conda deactivate
