#!/bin/sh

#SBATCH --job-name=hCALC.PSEUDOPOT.118_ORGANESSON.VASP.GW_and_BSE.FCC.K666_E300_NB128_scGW.GW0.
#SBATCH -t 0-72:00
#SBATCH -N 4
#SBATCH -n 112
#SBATCH --mem-per-cpu=12G
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -o /home/mewes/err/vasp-%j
#SBATCH --mail-user=janmewes@janmewes.de
#SBATCH -p bigmem
echo This job was submitted from the computer:
echo $SLURM_SUBMIT_HOST
echo and the directory:
echo $SLURM_SUBMIT_DIR
echo
echo It is running on the compute node:
echo $SLURM_CLUSTER_NAME
echo
echo The local scratch directory "(located on the compute node)" is:
echo $SCRATCH
echo

module load vasp/mkl/intelmpi/intel/5.4.4-SuperHeavy-D3
module list 2>&1
echo


echo "---- The Job is executed at $(date) on $(hostname) ----"

# Execute the program
cp -v * $SLURM_SUBMIT_DIR
cd $SLURM_SUBMIT_DIR
[ -e output_OLD ] && cp output_OLD output_OLDER
[ -e output ] && cp output output_OLD
[ -e XDATCAR_OLD ] && cp XDATCAR_OLD XDATCAR_OLDER
[ -e XDATCAR ] && cp XDATCAR XDATCAR_OLD
srun -n 56 vasp_ncl > output_0
cp OUTCAR OUTCAR_0

srun -n 56 vasp_ncl > output_1
cp OUTCAR OUTCAR_1

srun -n 56 vasp_ncl > output_2
cp OUTCAR OUTCAR_2

srun -n 56 vasp_ncl > output_3
cp OUTCAR OUTCAR_3

srun -n 56 vasp_ncl > output_4
cp OUTCAR OUTCAR_4

echo "---- The Job has finished at $(date) ----"

