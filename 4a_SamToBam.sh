#!/bin/bash
#SBATCH --job-name=SAM_to_BAM
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16g
#SBATCH --time=12:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --array=1-5

source $HOME/.bash_profile #Allows conda use
conda activate tbrucei #Activates tbrucei env

cd bowtie/blood/ #Moves into bowtie outdir for blood sample

SAMPLE="Blood"$SLURM_ARRAY_TASK_ID #Sets sample names

samtools view -bS "$SAMPLE.sam.gz" > "$SAMPLE.bam" #Converts from SAM to BAM
samtools sort "$SAMPLE.bam" -o "sorted_$SAMPLE.bam" #Sorts the BAM
samtools index "sorted_$SAMPLE.bam" #Indexes sorted BAM

cd ../csf #Moves into bowtie outdir for csf samples

SAMPLE="CSF"$SLURM_ARRAY_TASK_ID

samtools view -bS "$SAMPLE.sam.gz" > "$SAMPLE.bam"
samtools sort "$SAMPLE.bam" -o "sorted_$SAMPLE.bam"
samtools index "sorted_$SAMPLE.bam"
#Runs as above on the other samples


