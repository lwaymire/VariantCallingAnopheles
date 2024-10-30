#!/usr/bin/bash
#PBS -l nodes=1:ppn=15

# Here we are locating the directory with data that we are working on and the results will be saved.
# "<absolute/path/to/the/working/directory>" part to the absoulute path to your data files
cd <absolute/path/to/the/working/directory>

# Here we are setting the background for conda environment activation. This will retrieve details of the packages installed on Miniconda.
eval "$(conda shell.bash hook)"
conda activate bioinfo

#in the same directory where your .fq files are, create a file named "samplenames.txt" where you list all your samples that you want to run without file extensions. 
#Here we are aligning to An stephensi genome, and filtering out anything that doesn't align. then exporting to .bam format.
for i in `cat samplenames.txt`
do

bowtie2 -x path/to/reference/Anstep ${i}.fq --no-unal -p 15 | samtools view -bS -o ${i}_output.bam
done
