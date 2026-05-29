#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=0-12:00:00
#SBATCH --cluster=gpu
#SBATCH --partition=l40s
#SBATCH --gres=gpu:4
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --mail-user=aaf92@pitt.edu
#SBATCH --mail-type=FAIL
#SBATCH --time=12:00:00


# load relevant modulese and conda env
module purge
module load gcc/8.2.0
module load python/ondemand-jupyter-python3.10
module load cuda/12.2.0
source activate chrombpnet_v2

# Get current fold number (0 to 4)
FOLD="fold${SLURM_ARRAY_TASK_ID}"

# Print Start Time
echo "==== Job started at: $(date) for ${FOLD} ===="

# Print End Time
echo "==== Job finished at: $(date) for ${FOLD} ===="
