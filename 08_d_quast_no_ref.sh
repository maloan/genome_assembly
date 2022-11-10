#!/usr/bin/env bash

#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=quast_no_ref
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/akurtz/assembly_annotation_course/outputs/output_quast_without_%j.o
#SBATCH --error=/data/users/akurtz/assembly_annotation_course/outputs/error_quast_without_%j.e

# add module
module add UHTS/Quality_control/quast/4.6.0

# directories
WORK_DIR=/data/users/akurtz/assembly_annotation_course/assemblies
cd $WORK_DIR
mkdir without_ref

quast.py \
$WORK_DIR/flye/assembly.fasta \
$WORK_DIR/canu/An1_3.contigs.fasta \
$WORK_DIR/flye/pilon.fasta \
$WORK_DIR/canu/pilon.fasta \
-G /data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff \
--eukaryote --est-ref-size 135000000 --threads 8 --labels flye,canu,flyePolished,canuPolished --no-sv -o $WORK_DIR/without_ref/
