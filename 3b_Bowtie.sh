#!/bin/bash
#SBATCH --job-name=bowtie
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
conda activate tbrucei #Activates conda env

cd bowtie #Enters bowtie

SAMPLE="Blood"$SLURM_ARRAY_TASK_ID"_trimmed.fq.gz" #Sets sample name
SAM="Blood"$SLURM_ARRAY_TASK_ID".sam.gz" #Sets SAM file name
LOG="Blood"$SLURM_ARRAY_TASK_ID".log" #Sets log file name

cd blood #Moves to blood
bowtie2 -x ../index/tbrucei \
        -U ../../trimmed/blood/$SAMPLE \
        -p 8 \
        -S "./$SAM" \
        2> "./$LOG"
#Indexes blood samples. Sets names to $SAMPLE above. Uses 8 threads, and outputs as a gzipped SAM. Creates a log file

SAMPLE="CSF"$SLURM_ARRAY_TASK_ID"_trimmed.fq.gz" #Sets sample name
SAM="CSF"$SLURM_ARRAY_TASK_ID".sam.gz" #Sets SAM file name
LOG="CSF"$SLURM_ARRAY_TASK_ID".log" #Sets log file name

cd ../csf
bowtie2 -x ../index/tbrucei \ #Sets sample name
        -U ../../trimmed/csf/$SAMPLE \ #Sets trimmed fastw location
        -p 8 \ #Cores
        -S "./$SAM" \
        2> "./$LOG"

#Indexes csf samples. Sets names to $SAMPLE above. Uses 8 threads, and outputs as a gzipped SAM. Creates a log file


