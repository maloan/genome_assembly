#!/usr/bin/env bash

#SBATCH --time=08:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=16
#SBATCH --partition=pall
#SBATCH --job-name=flye_assembly
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=begin,end,fail

#set the directories
WORK_DIR=/data/users/akurtz/assembly_annotation_course/assemblies/flye
READ_DIR=/data/users/akurtz/assembly_annotation_course/participant_3

#load module
module load UHTS/Assembler/flye/2.8.3

#run flye
flye --pacbio-raw ${READ_DIR}/pacbio/* --out-dir ${WORK_DIR} --threads 16
