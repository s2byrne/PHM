#!/bin/bash
#script to run PFMv2
cd /glade/u/home/$USER/ROMS_all/PHM
#source /home/mspydell/.bashrc
module load conda/latest 
# module load hdf5/1.12.3
# module load netcdf/4.9.2

module load ncarenv/24.12
module load craype/2.7.31
module load intel/2024.2.1
module load ncarcompilers/1.0.0
module load libfabric/1.15.2.0
module load cray-mpich/8.1.29
module load hdf5/1.12.3
module load netcdf/4.9.2
module load nco/5.3.1 

# check to see what git branch we are on
EXPECTED_BRANCH="PHM_development" # Or "master", "develop", etc.

current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch is: $current_branch"

if [ "$current_branch" != "$EXPECTED_BRANCH" ]; then
  echo "Error: You are not on the '$EXPECTED_BRANCH' branch."
  echo "switching branches..."
  git switch $EXCPECTED_BRANCH
  current_branch2=$(git rev-parse --abbrev-ref HEAD)
  echo "Current branch is now: $current_branch2"
  # exit 1 # Exit with an error code
fi
echo "Successfully on the '$EXPECTED_BRANCH' branch. Proceeding with script..."

cd /glade/u/home/$USER/ROMS_all/PHM/driver

#########
#Initialize conda, needed for conda activate to work
eval "$(conda shell.bash hook)"
# Activate the desired environment
conda activate PHM-env

########

dateZ=$(date '+%Y%m%d')
fstdout=/glade/u/home/$USER/ROMS_all/runs/log/LVs_hindcast_system.log 

in_py="/glade/u/home/$USER/ROMS_all/PHM/sdpm_py_util/phm_model_info_devel_wLV4.py"
info_pkl="/glade/work/$USER/PHM_Simulations/phm_info.pkl"
python -u -W "ignore" driver_run_pfm_phm.py $in_py $info_pkl > ${fstdout}  2>&1

cd /glade/u/home/$USER/ROMS_all/PHM