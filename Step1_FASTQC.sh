#!/usr/bin/bash
#PBS -l nodes=1:ppn=5
 
# Here we are locating the directory with data that we are working on and the results will be saved.
# "<absolute/path/to/the/working/directory>" part to the absoulute path to your data files
cd <absolute/path/to/the/working/directory>
 
# Here we are setting the background for conda environment activation. This will retrieve details of the packages installed on Miniconda.
eval "$(conda shell.bash hook)"
conda activate bioinfo

# Here we are unzipping files with gunzip.
gunzip *.gz

# Here we are running the fastQC program. 
fastqc -t 5 *.fq
 
echo "worked!"
