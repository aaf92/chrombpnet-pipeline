#!/bin/bash                                     
#SBATCH --job-name=bwa   
#SBATCH --array=1-12               
#SBATCH --nodes=1
#SBATCH --cluster=htc
#SBATCH --partition=htc   
#SBATCH --cpus-per-task=8   
#SBATCH --mem=16g
#SBATCH --mail-user=aaf92@pitt.edu    
#SBATCH --mail-type=END,FAIL               
#SBATCH --time=0-12:00:00  

module load gcc/8.2.0
module load bwa/0.7.17
module load samtools

ref_path="/bgfs/rgottschalk/reference_genomes/mm10/BWA_indexed/mm10.fa.gz"
fastq_path="/ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/Data/ATAC-seq/fastq"
cd $fastq_path
i=$(ls *_trimmed.fastq.gz / | awk "NR==$SLURM_ARRAY_TASK_ID")

# align 
j="$i".sam
bwa mem -t 8 "$ref_path" "$i" > "$j"

# convert SAM to BAM
# remove reads with quality less than 15 and unassigned reads
k="$i".bam
samtools view -b -q 15 -F 4 "$j" -o "$k"

# sort BAM files
samtools sort "$k" -o sorted_"$k"

# remove duplicate reads and index
samtools rmdup sorted_"$k" sorted_noDups_"$k"
samtools index sorted_noDups_"$k"

# remove original BAM and SAM file
rm "$j"
rm "$k"
