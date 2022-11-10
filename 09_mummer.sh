#!/usr/bin/env bash

#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=16G
#SBATCH --cpus-per-task=8
#SBATCH --partition=pall
#SBATCH --job-name=mummerplot
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/akurtz/assembly_annotation_course/outputs/output_mumer_%j.o
#SBATCH --error=/data/users/akurtz/assembly_annotation_course/outputs/error_mummer_%j.e


# load module 
module add UHTS/Analysis/mummer/4.0.0beta1

# set directories
WORK_DIR=/data/users/akurtz/assembly_annotation_course
ANO_REF=/data/courses/assembly-annotation-course/references

# mummerplot 
#mummerplot --prefix flye -R $ANO_REF/*fa -Q $WORK_DIR/assemblies/flye/assembly.fasta --filter -t png --large --layout $WORK_DIR/comparing/flye.delta
#mummerplot --prefix flye_polished -R $ANO_REF/*fa -Q $WORK_DIR/assemblies/flye/pilon.fasta --filter -t png --large --layout $WORK_DIR/comparing/flye_polished.delta

#mummerplot --prefix canu -R $ANO_REF/*fa -Q $WORK_DIR/assemblies/canu/An1_3.contigs.fasta --filter -t png --large --layout $WORK_DIR/comparing/canu.delta
#mummerplot --prefix canu_polished -R $ANO_REF/*fa -Q $WORK_DIR/assemblies/canu/pilon.fasta --filter -t png --large --layout $WORK_DIR/comparing/canu_polished.delta

mummerplot \
--prefix canu_polished_vs_flye_polished \
-R $WORK_DIR/assemblies/flye/pilon.fasta \
-Q $WORK_DIR/assemblies/canu/pilon.fasta \
--filter -t png --large --layout \
$WORK_DIR/comparing/canu_polished_vs_flye_polished.delta

mummerplot \
--prefix canu_vs_flye \
-R $WORK_DIR/assemblies/flye/assembly.fasta \
-Q $WORK_DIR/assemblies/canu/An1_3.contigs.fasta \
--filter -t png --large --layout \
$WORK_DIR/comparing/canu_vs_flye.delta
