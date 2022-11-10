#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=canu_assembly
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=begin,end,fail

#set the directories
WORK_DIR=/data/users/akurtz/assembly_annotation_course/assemblies/canu
READ_DIR=/data/users/akurtz/assembly_annotation_course/participant_3

#load module 
module load UHTS/Assembler/canu/2.1.1

canu -p An1_3 -d ${WORK_DIR} genomeSize=125m maxThreads=16 maxMemory=64 gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY" gridOptions="--partition=pall --mail-user=ananda.kurth@students.unibe.ch" -pacbio ${READ_DIR}/pacbio/*
