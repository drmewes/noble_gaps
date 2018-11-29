#!/bin/sh

#SBATCH --job-name=hCALC.PSEUDOPOT.118_ORGANESSON.VASP.GW_and_BSE.FCC.K777_E300_NB128_scGW.
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

cd GW0

for i in 1 2 3 4 ; do 
srun -n 112 vasp_ncl > output_$i
echo "### GW iteration $((i+1)) ###" >> gaps.out
/home/mewes/bin/vasp_tools/sogap_GW.sh OUTCAR >> gaps.out
cp OUTCAR OUTCAR_$i
echo "... done with iteration $i ..."
done

echo "all done."

echo "---- The Job has finished at $(date) ----"

