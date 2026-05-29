#!/bin/bash                                     
#SBATCH --job-name=macs3
#SBATCH --nodes=1
#SBATCH --cluster=htc
#SBATCH --partition=htc
#SBATCH --cpus-per-task=8
#SBATCH --mem=8g       
#SBATCH --mail-user=aaf92@pitt.edu    
#SBATCH --mail-type=END,FAIL               
#SBATCH --time=12:00:00 

# load modules
module load macs/3.0.3

# Define the BAM file and output directory
bam_file="/ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq/trimmed_data/bam/UT_merged.bam"
outdir="/ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq/trimmed_data/peakcall_res/UT"

mkdir -p "$outdir"

# peak calling:
macs3 callpeak -t "$bam_file" \
--outdir "$outdir" \
-n $(basename "$bam_file" .bam) \
--nomodel \
-g mm \
--shift -100 \
--extsize 200 \
-p 0.01