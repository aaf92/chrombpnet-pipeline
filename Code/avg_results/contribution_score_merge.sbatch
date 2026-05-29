#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=0-12:00:00
#SBATCH --cluster=gpu
#SBATCH --partition=l40s
#SBATCH --gres=gpu:4
#SBATCH --cpus-per-task=16
#SBATCH --mem=128G
#SBATCH --mail-user=aaf92@pitt.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --time=12:00:00
#SBATCH -e slurm-%j.err
#SBATCH -o slurm-%j.out

# load relevant modulese and conda env
module purge
module load gcc/8.2.0
module load python/ondemand-jupyter-python3.10
module load cuda/11.2.0
source activate chrombpnet_v2

# Print Start Time
echo "==== Job started at: $(date) ===="

# navigate to data directory:
cd /ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/chrombpnet/Code/avg_results

# merge contribution score outputs
python3 contribution_score_h5_merge.py

# Print End Time
echo "==== Job ended at: $(date) ===="