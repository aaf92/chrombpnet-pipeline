#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cluster=gpu
#SBATCH --partition=a100_nvlink
#SBATCH --gres=gpu:4
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --mail-user=aaf92@pitt.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --time=1-00:00:00
#SBATCH -e slurm-%j.err
#SBATCH -o slurm-%j.out
#SBATCH --array=0-4

# load relevant modulese and conda env
module purge
module load gcc/8.2.0
module load python/ondemand-jupyter-python3.10
module load cuda/11.2.0
source activate chrombpnet_v2

# Get current fold number (0 to 4)
FOLD="fold${SLURM_ARRAY_TASK_ID}"

# Print Start Time
echo "==== Job started at: $(date) for ${FOLD} ===="

# navigate to data directory:
cd /ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq

mkdir -p ../../chrombpnet/Results/predictions_contribs/${FOLD}_contribs

# prediction
chrombpnet contribs_bw \
        -m ../../chrombpnet/Results/chrombpnet_models/${FOLD}/models/chrombpnet_nobias.h5 \
        -g ./mm10/mm10.fa \
        -c ./mm10/mm10.chrom.sizes \
        -r ./trimmed_data/peakcall_res/sorted_peaks_no_blacklist.bed \
        -op ../../chrombpnet/Results/predictions_contribs/${FOLD}_contribs/${FOLD}

# Print End Time
echo "==== Job finished at: $(date) for ${FOLD} ===="s
