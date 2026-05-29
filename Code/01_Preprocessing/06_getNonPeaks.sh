#!/bin/bash
#SBATCH --job-name=getNonPeaks
#SBATCH --nodes=1
#SBATCH --cluster=htc
#SBATCH --partition=htc
#SBATCH --cpus-per-task=8
#SBATCH --mem=8g
#SBATCH --mail-user=aaf92@pitt.edu    
#SBATCH --mail-type=END,FAIL               
#SBATCH --time=12:00:00                                      
#SBATCH --array=0-4

module purge
module load python/ondemand-jupyter-python3.11
source activate chrombpnet_v2

prefix="UT"

atac_dir="/ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq"
peaks_dir="${atac_dir}/trimmed_data/peakcall_res/${prefix}"
splits_dir="${atac_dir}/trimmed_data/splits/${prefix}"

mkdir -p ${splits_dir}

cd $atac_dir

FOLD="fold${SLURM_ARRAY_TASK_ID}"

echo "Processing nonpeaks for ${prefix} ${FOLD}..."

chrombpnet prep nonpeaks -g ./mm10/mm10.fa \
    -p ${peaks_dir}/${prefix}_merged_sorted_peaks_no_blacklist.bed \
    -c ./mm10/mm10.chrom.sizes \
    -fl ${splits_dir}/${FOLD}.json \
    -br ./mm10/mm10.blacklist.bed.gz \
    -o ${splits_dir}/output_${FOLD}

echo "Done processing ${prefix} ${FOLD}!"