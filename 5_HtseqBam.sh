#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=5g
#SBATCH --time=1:00:00
#SBATCH --job-name=htseq
#SBATCH --mail-type=ALL
#SBATCH --array=1-5
#SBATCH --mail-user=XXX@nottingham.ac.uk

source $HOME/.bash_profile
conda activate tbrucei

#BAM file names for array
BLOOD="sorted_Blood"$SLURM_ARRAY_TASK_ID".bam"
CSF="sorted_CSF"$SLURM_ARRAY_TASK_ID".bam"

#settind directories
#replace XXX with file path to home directory
PD=XXX

#Input file paths for sorted BAM files and gene annotation
BLOOD_PATH="$PD"/bowtie/blood/$BLOOD
CSF_PATH=$PD"/bowtie/csf/$CSF

#if reference genomes have been moved then change this file path
GENE="$PD"/ReferenceGenomes/TBruceiRef.gff

#Output path and file names
mkdir -p "$PD"/counts

OUTDIR="$PD"/counts
BLOOD_OUT="Blood"$SLURM_ARRAY_TASK_ID".tsv"
CSF_OUT="CSF"$SLURM_ARRAY_TASK_ID".tsv"


htseq-count --format bam -a 0 -t mRNA -i ID "$BLOOD_PATH" "$GENE" > "$OUTDIR"/"$BLOOD_OUT"
htseq-count --format bam -a 0 -t mRNA -i ID "$CSF_PATH" "$GENE" > "$OUTDIR"/"$CSF_OUT"
#Runs htseq on both samples

conda deactivate
