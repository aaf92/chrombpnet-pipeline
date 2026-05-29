#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=4-00:00:00
#SBATCH --cluster=gpu
#SBATCH --partition=l40s
#SBATCH --gres=gpu:4
#SBATCH --cpus-per-task=16
#SBATCH --mem=250G
#SBATCH --mail-user=aaf92@pitt.edu
#SBATCH --mail-type=BEGIN,END,FAIL
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

cd /ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/chrombpnet/Results

echo "==== Modisco Motifs started at: $(date) ===="

modisco motifs -i ./predictions_contribs/merged_count_scores.h5 -n 1000000 -o ./modisco/count_modisco_results.h5

echo "==== Modisco Motifs ended at: $(date) ===="

echo "==== Modisco Motifs Report started at: $(date) ===="

modisco report -i ./modisco/count_modisco_results.h5 -o ./modisco/count_report/ -s ./modisco/count_report/ -m /ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq/jaspar_motifs/JASPAR_motifname_fix.txt

echo "==== Modisco Motifs Report ended at: $(date) ===="

echo "==== Modisco Motifs started at: $(date) ===="

modisco motifs -i ./predictions_contribs/merged_profile_scores.h5 -n 1000000 -o ./modisco/profile_modisco_results.h5

echo "==== Modisco Motifs ended at: $(date) ===="

echo "==== Modisco Motifs Report started at: $(date) ===="

modisco report -i ./modisco/profile_modisco_results.h5 -o ./modisco/profile_report/ -s ./modisco/profile_report/ -m /ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq/jaspar_motifs/JASPAR_motifname_fix.txt

echo "==== Modisco Motifs Report ended at: $(date) ===="

# Print End Time
echo "==== Job ended at: $(date) ===="
