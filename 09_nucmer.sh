#!/usr/bin/env bash

#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=16G
#SBATCH --cpus-per-task=8
#SBATCH --partition=pall
#SBATCH --job-name=indexing
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=fail,end

# load module 
module add UHTS/Analysis/mummer/4.0.0beta1

ANO_REF=/data/courses/assembly-annotation-course/references
WORK_DIR=/data/users/akurtz/assembly_annotation_course

# nucmer 
#nucmer --prefix flye --breaklen 1000 --mincluster 1000 $ANO_REF/*.fa $WORK_DIR/assemblies/flye/assembly.fasta
#nucmer --prefix flye_polished --breaklen 1000 --mincluster 1000 $ANO_REF/*.fa $WORK_DIR/assemblies/flye/pilon.fasta

#nucmer --prefix canu --breaklen 1000 --mincluster 1000 $ANO_REF/*.fa $WORK_DIR/assemblies/canu/An1_3.contigs.fasta
#nucmer --prefix canu_polished --breaklen 1000 --mincluster 1000 $ANO_REF/*.fa $WORK_DIR/assemblies/canu/pilon.fasta

nucmer --prefix canu_vs_flye --breaklen 1000 --mincluster 1000 $WORK_DIR/assemblies/flye/assembly.fasta $WORK_DIR/assemblies/canu/An1_3.contigs.fasta
nucmer --prefix canu_polished_vs_flye_polished --breaklen 1000 --mincluster 1000 $WORK_DIR/assemblies/flye/pilon.fasta $WORK_DIR/assemblies/canu/pilon.fasta
