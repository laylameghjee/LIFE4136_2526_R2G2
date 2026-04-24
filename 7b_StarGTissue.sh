#!/bin/bash
#SBATCH --job-name=STAR_tissue
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=60g
#SBATCH --time=48:00:00
#SBATCH --mail-user=XXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --array=75-80

source $HOME/.bash_profile #Allows conda use
conda activate tbrucei #Activates tbrucei env

#settind directories
#replace XXX with file path to home directory
PD=XXX

mkdir -p "$PD"/STAR
mkdir -p "$PD"/STAR/tissue

#set XXX to file path to fastq files
INDIR=XXX


READ1="$INDIR""$SLURM_ARRAY_TASK_ID"_1.fastq.gz
READ2="$INDIR""$SLURM_ARRAY_TASK_ID"_2.fastq.gz
OUT="$PD"/STAR/tissue/"$SLURM_ARRAY_TASK_ID"_ts

#change XXX to file path for reference genomes
STAR --quantMode GeneCounts \
        --genomeDir XXX/ReferenceGenomes/ \
        --readFilesIn "$READ1" "$READ2" \
        --readFilesCommand zcat \
        --runThreadN 32 \
        --outFileNamePrefix "$OUT"


