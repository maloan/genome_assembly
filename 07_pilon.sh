#!/usr/bin/env bash

#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=16
#SBATCH --partition=pall
#SBATCH --job-name=pilon
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --dependency=afterok:9263341

# add modules
module load UHTS/Analysis/pilon/1.22;
java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar

# set the directories
WORK_DIR=/data/users/akurtz/assembly_annotation_course/assemblies
READ_DIR=/data/users/akurtz/assembly_annotation_course/participant_3/Illumina

# pilon flye
pilon --genome ${WORK_DIR}/flye/assembly.fasta --frags ${WORK_DIR}/flye/flye.bam --outdir ${WORK_DIR}/flye/

# pilon canu
pilon --genome ${WORK_DIR}/canu/An1_3.contigs.fasta --frags ${WORK_DIR}/canu/canu.bam --outdir ${WORK_DIR}/canu/
