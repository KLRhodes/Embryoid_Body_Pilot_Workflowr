#!/bin/bash

# Adapted from Peter Carbonetto fit_all_models_purified_pbmc.sh

# The shell commands below will submit Slurm jobs to perform the
# Poisson NMF model fitting for different choices of the model
# parameters and optimization settings.

SCRIPT_PREFIT=prefit_poisson_nmf.sbatch
SCRIPT_FIT=fit_poisson_nmf.sbatch

# "Pre-fit" the models.
#                        k outfile
#sbatch ${SCRIPT_PREFIT}  6 prefit-k=6
#sbatch ${SCRIPT_PREFIT} 10 prefit-k=10
#sbatch ${SCRIPT_PREFIT} 15 prefit-k=15
#sbatch ${SCRIPT_PREFIT} 20 prefit-k=20
#sbatch ${SCRIPT_PREFIT} 25 prefit-k=25
#sbatch ${SCRIPT_PREFIT} 30 prefit-k=30

# Fit rank-6 factorizations, with and without extrapolation.
#                    k method  ex outfile
sbatch ${SCRIPT_FIT} 6 em      no fit-em-k=6
#sbatch ${SCRIPT_FIT} 6 ccd     no fit-ccd-k=6
#sbatch ${SCRIPT_FIT} 6 scd     no fit-scd-k=6
#sbatch ${SCRIPT_FIT} 6 em     yes fit-em-ex-k=6
#sbatch ${SCRIPT_FIT} 6 ccd    yes fit-ccd-ex-k=6
sbatch ${SCRIPT_FIT} 6 scd    yes fit-scd-ex-k=6

# Fit rank-10 factorizations, with and without extrapolation.
#                     k method  ex outfile
sbatch ${SCRIPT_FIT} 10 em      no fit-em-k=10
#sbatch ${SCRIPT_FIT} 10 ccd     no fit-ccd-k=10
#sbatch ${SCRIPT_FIT} 10 scd     no fit-scd-k=10
#sbatch ${SCRIPT_FIT} 10 em     yes fit-em-ex-k=10
#sbatch ${SCRIPT_FIT} 10 ccd    yes fit-ccd-ex-k=10
sbatch ${SCRIPT_FIT} 10 scd    yes fit-scd-ex-k=10

# Fit rank-15 factorizations, with and without extrapolation.
#                     k method  ex outfile
sbatch ${SCRIPT_FIT} 15 em      no fit-em-k=15
#sbatch ${SCRIPT_FIT} 15 ccd     no fit-ccd-k=15
#sbatch ${SCRIPT_FIT} 15 scd     no fit-scd-k=15
#sbatch ${SCRIPT_FIT} 15 em     yes fit-em-ex-k=15
#sbatch ${SCRIPT_FIT} 15 ccd    yes fit-ccd-ex-k=15
sbatch ${SCRIPT_FIT} 15 scd    yes fit-scd-ex-k=15

# Fit rank-20 factorizations, with and without extrapolation.
#                     k method  ex outfile
sbatch ${SCRIPT_FIT} 20 em      no fit-em-k=20
#sbatch ${SCRIPT_FIT} 20 ccd     no fit-ccd-k=20
#sbatch ${SCRIPT_FIT} 20 scd     no fit-scd-k=20
#sbatch ${SCRIPT_FIT} 20 em     yes fit-em-ex-k=20
#sbatch ${SCRIPT_FIT} 20 ccd    yes fit-ccd-ex-k=20
sbatch ${SCRIPT_FIT} 20 scd    yes fit-scd-ex-k=20

# Fit rank-25 factorizations, with and without extrapolation.
#                     k method  ex outfile
sbatch ${SCRIPT_FIT} 25 em      no fit-em-k=25
#sbatch ${SCRIPT_FIT} 25 ccd     no fit-ccd-k=25
#sbatch ${SCRIPT_FIT} 25 scd     no fit-scd-k=25
#sbatch ${SCRIPT_FIT} 25 em     yes fit-em-ex-k=25
#sbatch ${SCRIPT_FIT} 25 ccd    yes fit-ccd-ex-k=25
sbatch ${SCRIPT_FIT} 25 scd    yes fit-scd-ex-k=25

# Fit rank-30 factorizations, with and without extrapolation.
#                     k method  ex outfile
sbatch ${SCRIPT_FIT} 30 em      no fit-em-k=30
#sbatch ${SCRIPT_FIT} 30 ccd     no fit-ccd-k=30
#sbatch ${SCRIPT_FIT} 30 scd     no fit-scd-k=30
#sbatch ${SCRIPT_FIT} 30 em     yes fit-em-ex-k=30
#sbatch ${SCRIPT_FIT} 30 ccd    yes fit-ccd-ex-k=30
sbatch ${SCRIPT_FIT} 30 scd    yes fit-scd-ex-k=30
