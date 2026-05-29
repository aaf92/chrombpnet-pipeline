#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cluster=gpu
#SBATCH --partition=a100
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --mail-user=aaf92@pitt.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --time=1-00:00:00
#SBATCH -e slurm-%j.err
#SBATCH -o slurm-%j.out
#SBATCH --array=0-4

# load relevant modules and conda env
module purge
module load gcc/8.2.0
module load python/ondemand-jupyter-python3.11
module load cuda/11.2.0
module load cudnn/8.1.0.77-11.2
source activate chrombpnet_v2

prefix="UT"
bias_thresh="0.7"

atac_dir="/ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq"
peaks_dir="${atac_dir}/trimmed_data/peakcall_res/${prefix}"
results_dir="/ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/chrombpnet/Results"
model_dir="${results_dir}/bias_factorized_model/${prefix}/bias_thresh_${bias_thresh}"
contribs_dir="${results_dir}/predictions_contribs/${prefix}/bias_thresh_${bias_thresh}"

FOLD="fold${SLURM_ARRAY_TASK_ID}"

mkdir -p ${contribs_dir}/${FOLD}

echo "==== Job started at: $(date) for ${prefix} ${FOLD} bias_thresh=${bias_thresh} ===="

cd $atac_dir

chrombpnet contribs_bw \
        -m ${model_dir}/${FOLD}/models/chrombpnet_nobias.h5 \
        -g ./mm10/mm10.fa \
        -c ./mm10/mm10.chrom.sizes \
        -r ${peaks_dir}/${prefix}_merged_sorted_peaks_no_blacklist.bed \
        -op ${contribs_dir}/${FOLD}/${FOLD}

echo "==== Job finished at: $(date) for ${prefix} ${FOLD} bias_thresh=${bias_thresh} ===="