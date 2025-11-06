#!/bin/bash
#PBS -N realistic_LV123_test
#PBS -A UCSD0074
#PBS -j oe
#PBS -k eod
#PBS -q main
#PBS -l walltime=00:10:00
#PBS -l select=6:ncpus=64:mpiprocs=64

module purge
module load ncarenv/24.12
module load craype/2.7.31
module load intel/2024.2.1
module load ncarcompilers/1.0.0
module load libfabric/1.15.2.0
module load cray-mpich/8.1.29
module load hdf5/1.12.3
module load netcdf/4.9.2

time {
### Compile & Run MPI Program
MYAPP=$lv1_executable$
mpirun -v -n $np$ -ppn 64 $MYAPP  $lv1_infile_local$  > $lv1_logfile_local$
}

