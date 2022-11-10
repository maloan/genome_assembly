#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=12
#SBATCH --partition=pall
#SBATCH --job-name=trinity_assembly
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=begin,end

#set the directories
WORK_DIR=/data/users/akurtz/assembly_annotation_course/assemblies/trinity
READ_DIR=/data/users/akurtz/assembly_annotation_course/participant_3

#load module
module load UHTS/Assembler/trinityrnaseq/2.5.1;

#run trinity
Trinity --seqType fq --max_memory 48G --single ${READ_DIR}/RNAseq/ERR754061_1.fastq.gz,${READ_DIR}/RNAseq/ERR754061_2.fastq.gz --output ${WORK_DIR} --CPU 12
