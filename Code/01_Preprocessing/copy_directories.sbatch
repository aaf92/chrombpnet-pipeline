#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8g
#SBATCH --cluster=htc
#SBATCH --time=2:00:00
#SBATCH --mail-user=aaf92@pitt.edu
#SBATCH --mail-type=END,FAIL

# Load any necessary modules
module purge

# Define source and destination directories
SRC_DIR="/bgfs/rgottschalk/Neha/20231207_BMDM_LPS_IL10_ATACseq/fastqc_trimmed"
DEST_DIR="/ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq/fastq/fastqc_trimmed"

# Create the destination directory
mkdir -p "$DEST_DIR"

# Copy entire contents of the source directory to the destination directory
cp -r "$SRC_DIR"/* "$DEST_DIR/"

echo "All contents copied from $SRC_DIR to $DEST_DIR!"
