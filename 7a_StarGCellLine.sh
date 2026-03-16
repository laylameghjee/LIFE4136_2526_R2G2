#!/bin/bash
#SBATCH --job-name=STAR_cell_line
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=60g
#SBATCH --time=48:00:00
#SBATCH --mail-user=XXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end

source $HOME/.bash_profile #Allows conda use
conda activate tbrucei #Activates conda env

mkdir STAR
cd STAR
mkdir cell_line
cd ../

READ1="XXX"$SLURM_ARRAY_TASK_ID"_1.fastq.gz"
READ2="XXX"$SLURM_ARRAY_TASK_ID"_2.fastq.gz"
OUT="XXX"$SLURM_ARRAY_TASK_ID"_cl"
#Sets sample names for each read

STAR --quantMode GeneCounts \
        --genomeDir XXX/ReferenceGenomes/ \
        --readFilesIn $READ1 $READ2 \
        --readFilesCommand zcat \
        --runThreadN 32 \
        --outFileNamePrefix $OUT
