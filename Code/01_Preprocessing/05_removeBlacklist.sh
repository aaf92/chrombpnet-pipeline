#!/bin/bash
#SBATCH --job-name=removeBlacklist
#SBATCH --nodes=1
#SBATCH --cluster=htc
#SBATCH --partition=htc
#SBATCH --cpus-per-task=8
#SBATCH --mem=8g
#SBATCH --mail-user=aaf92@pitt.edu    
#SBATCH --mail-type=FAIL               
#SBATCH --time=12:00:00                                      

module load bedtools/2.31.1

prefix="UT"

atac_dir="/ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq"
peaks_dir="${atac_dir}/trimmed_data/peakcall_res/${prefix}"

cd $atac_dir

echo "starting blacklist peak removal for ${prefix}..."

bedtools slop -i ./mm10/mm10.blacklist.bed.gz \
    -g ./mm10/mm10.chrom.sizes \
    -b 1057 > ${peaks_dir}/temp.bed

bedtools intersect -v \
    -a ${peaks_dir}/${prefix}_merged_sorted_peaks.bed \
    -b ${peaks_dir}/temp.bed \
    > ${peaks_dir}/${prefix}_merged_sorted_peaks_no_blacklist.bed

rm ${peaks_dir}/temp.bed

echo "done!"