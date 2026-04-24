#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=5g
#SBATCH --time=1:00:00
#SBATCH --job-name=SortBam
#SBATCH --mail-type=ALL
#SBATCH --array=1-5
#SBATCH --mail-user=XXX@nottingham.ac.uk

module load samtools-uoneasy/1.18-GCC-12.3.0

#settind directories
#replace XXX with file path to home directory
PD=XXX

cd "$PD"/bowtie


SAMPLE="Blood"$SLURM_ARRAY_TASK_ID
samtools sort blood/"$SAMPLE.bam.gz" -o blood/"$SAMPLE.sorted.bam.gz"

SAMPLE="CSF"$SLURM_ARRAY_TASK_ID
samtools sort csf/"$SAMPLE.bam.gz" -o csf/"$SAMPLE.sorted.bam.gz"
