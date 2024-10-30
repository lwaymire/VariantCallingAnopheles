#!/usr/bin/bash
#PBS -l nodes=1:ppn=5
 
# Here we are locating the directory with data that we are working on and the results will be saved.
# "<absolute/path/to/the/working/directory>" part to the absoulute path to your data files
cd <absolute/path/to/the/working/directory>
 
# setting background for conda environment activation
eval "$(conda shell.bash hook)"
 
# activating 'bioinfo' environment with conda
conda activate bioinfo

#unzip files
gunzip *.gz

# quality check
fastqc -t 5 *.fq
 
echo "worked!"
