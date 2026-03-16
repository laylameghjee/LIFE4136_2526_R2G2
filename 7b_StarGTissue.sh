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

cd XXX/STAR
mkdir tissue
cd ../

READ1="XXX"$SLURM_ARRAY_TASK_ID"_1.fastq.gz"
READ2="XXX"$SLURM_ARRAY_TASK_ID"_2.fastq.gz"
OUT="XXX/STAR/tissue/"$SLURM_ARRAY_TASK_ID"_ts"

STAR --quantMode GeneCounts \
        --genomeDir XXX/RefernceGenomes/ \
        --readFilesIn $READ1 $READ2 \
        --readFilesCommand zcat \
        --runThreadN 32 \
        --outFileNamePrefix $OUT


