#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --job-name=quast
#SBATCH --output=output_quast_%j.o
#SBATCH --error=error_quast_%j.e

PROJECT_PATH=`realpath .`
OUTPUT_PATH=$PROJECT_PATH

REF_DIR=/data/courses/assembly-annotation-course/references
REF_GENOME=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz
REF_ANNOTATION=/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff
WORK_DIR=/data/users/akurtz/assembly_annotation_course/assemblies

mkdir -p $OUTPUT_PATH
cd $WORK_DIR

# with ref
singularity exec \
    --bind $PROJECT_PATH,$REF_DIR \
    /data/courses/assembly-annotation-course/containers/quast_5.1.0rc1.sif \
    quast.py \
        -r $REF_GENOME \
        -g $REF_ANNOTATION \
        -t 8 \
        --eukaryote \
        --est-ref-size 135000000 \
        --no-sv \
        --large \
        $WORK_DIR/flye/assembly.fasta $WORK_DIR/canu/An1_3.contigs.fasta $WORK_DIR/flye/pilon.fasta $WORK_DIR/canu/pilon.fasta \
        -o $OUTPUT_PATH/with_ref \

