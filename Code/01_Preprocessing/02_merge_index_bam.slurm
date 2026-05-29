#!/bin/bash                                     
#SBATCH --job-name=merge_index_BAM
#SBATCH --nodes=1
#SBATCH --cluster=htc
#SBATCH --partition=htc
#SBATCH --cpus-per-task=8
#SBATCH --mem=8g
#SBATCH --mail-user=aaf92@pitt.edu    
#SBATCH --mail-type=FAIL               
#SBATCH --time=12:00:00 

module load gcc/15.1.0
module load samtools/1.22.1

bam_dir="/ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq/trimmed_data/bam"
output_prefix="UT_merged"

cd $bam_dir

# merge and index bam files
samtools merge -f ${output_prefix}_unsorted.bam \
    sorted_noDups_BMDMs_UT_A_ATAC_trimmed.fastq.gz.bam \
    sorted_noDups_BMDMs_UT_B_ATAC_trimmed.fastq.gz.bam \
    sorted_noDups_BMDMs_UT_C_ATAC_trimmed.fastq.gz.bam

samtools sort -@4 ${output_prefix}_unsorted.bam -o ${output_prefix}.bam
samtools index ${output_prefix}.bam