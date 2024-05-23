#!/bin/bash
	
#PBS -N metaSPAdes               ## job name
#PBS -l nodes=1:ppn=50           ## 1 node, 50 cores/processors
#PBS -l walltime=30:00:00        ## max time job will run
#PBS -m abe                      ## email notifications (aborted, begin and end)
	
# Loading metaSPAdes module
module load SPAdes/3.15.5-GCC-11.3.0

# assuming that you executed the command from the $VSC_DATA_VO/vsc47627 directory	
# Copy the read files from the sample you want to analyze to the working directory

cp $PBS_O_WORKDIR/01_assembly/DATA/022_009_230328_999_4855_318_01_4041_1.fq.gz $PBS_O_WORKDIR
cp $PBS_O_WORKDIR/01_assembly/DATA/022_009_230328_999_4855_318_01_4041_2.fq.gz $PBS_O_WORKDIR
	
# go to the working directory
	
cd $PBS_O_WORKDIR
	
# execute the metaSPAdes command
	
metaspades.py -m 350 -t 50 -1 022_009_230328_999_4855_318_01_4041_1.fq.gz -2 022_009_230328_999_4855_318_01_4041_2.fq.gz -o $PBS_O_WORKDIR/01_assembly/01_metaSPAdes/sample4855
