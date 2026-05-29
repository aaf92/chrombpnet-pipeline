#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8g
#SBATCH --cluster=htc
#SBATCH --partition=htc
#SBATCH --time=2:00:00
#SBATCH --mail-user=aaf92@pitt.edu
#SBATCH --mail-type=END,FAIL

# Load any necessary modules
module purge

# Define source and destination directories
SRC_DIR="/bgfs/rgottschalk/Neha/20231207_BMDM_LPS_IL10_ATACseq"
DEST_DIR="/ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq/fastq"

# Ensure the destination directory exists
mkdir -p "$DEST_DIR"

# Copy all FASTQ.GZ files from source to destination
cp "$SRC_DIR"/*fastq.gz "$DEST_DIR/"

echo "Copying completed!"
