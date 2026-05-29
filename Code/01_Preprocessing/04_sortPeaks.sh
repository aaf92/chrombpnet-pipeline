#!/bin/bash
#SBATCH --job-name=sortPeaks
#SBATCH --nodes=1
#SBATCH --cluster=htc
#SBATCH --partition=htc
#SBATCH --cpus-per-task=8
#SBATCH --mem=8g
#SBATCH --mail-user=aaf92@pitt.edu    
#SBATCH --mail-type=FAIL               
#SBATCH --time=12:00:00                                      

module load bedtools/2.31.1

peaks_dir="/ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq/trimmed_data/peakcall_res/UT"
prefix="UT_merged"

cd $peaks_dir

echo "sorting peaks for ${prefix}..."

cat ${prefix}_peaks.narrowPeak > temp.bed
bedtools sort -i temp.bed > ${prefix}_sorted_peaks.bed

rm temp.bed

echo "done!"