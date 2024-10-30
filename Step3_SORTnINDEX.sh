#!/usr/bin/bash
#PBS -l nodes=1:ppn=15

# Here we are locating the directory with data that we are working on and the results will be saved.
# "<absolute/path/to/the/working/directory>" part to the absoulute path to your data files
cd <absolute/path/to/the/working/directory>

# Here we are setting the background for conda environment activation. This will retrieve details of the packages installed on Miniconda.
eval "$(conda shell.bash hook)"
conda activate bioinfo

# The for loop will iterate through the list of bam files in the directory specified in line 9
# In the first line of the body of the for loop the input bam file will be sorted and a new sorted bam file will be saved under the name that ends with "...sorted.bam" extension
# -@ defines the number of threads used in the process and should match with the number of threads specified in line 2
# In the second line of the body of the for loop the newly created sorted bam file will be indexed and the output index will be saved within the working directory with ".bai" extension
for i in `ls *_output.bam`
do 
samtools sort $i -o $i.sorted.bam -@ 15
samtools index $i.sorted.bam -@ 15
done
