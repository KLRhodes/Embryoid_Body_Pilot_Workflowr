#!/usr/bin/env Rscript

# This script adapted from Peter Carbonetto fit_poisson_nmf_purified_pbmc.R
# which fit a Poisson non-negative factorization to the purified PBMC
# single-cell RNA-seq data of Zheng et al (2017).
#
# This version runs the analysis on input data prepared previously
# from a seurat object
#
# This script is intended to be run from the command-line shell, with
# options that are processed with the optparse package. For example,
# to fit a rank-4 Poisson non-negative matrix factorization by running
# 500 SCD updates with extrapolation, 2 threads, with estimates
# initialized from fit.rds, and with results saved to test.rds, run
# this command:
#
#   ./fit_poisson_nmf_purified_pbmc.R -k 4 --method scd --nc 2 \
#     --extrapolate --numiter 500 --prefit fit.rds -o test.rds
#
# Poisson non-negative matrix factorization by running 1,000 EM
# updates without extrapolation, without multithreading, and with
# results saved to out.rds. The estimates of the factors and loadings
# are initialized from ../output/prefit-k=3.rds by default when k = 3.
#

# Load a few packages.
library(Matrix)
library(optparse)
library(readr)
library(fastTopics)

# Process the command-line arguments.
parser <- OptionParser()
parser <- add_option(parser,c("--out","-o"),type="character",default="out.rds")
parser <- add_option(parser,c("--k","-k"),type = "integer",default = 3)
parser <- add_option(parser,"--method",type = "character",default = "em")
parser <- add_option(parser,"--nc",type = "integer",default = 1)
parser <- add_option(parser,"--extrapolate",action = "store_true")
parser <- add_option(parser,"--numiter",type = "integer",default = 1000)
parser <- add_option(parser,"--prefit",type = "character",default = "auto")
out    <- parse_args(parser)
outfile     <- out$out
k           <- out$k
method      <- out$method
nc          <- out$nc
#numiter     <- out$numiter
#hard setting numiter to 500 here, can revert to the optionparser input using the line above
numiter <- 500
prefit.file <- out$prefit
extrapolate <- !is.null(out$extrapolate)
rm(parser,out)

# Initialize the sequence of pseudorandom numbers.
set.seed(1)

# LOAD DATA
# ---------
# Load the previously prepared data.
cat("Loading data.\n")
load("/project2/gilad/katie/Pilot_HumanEBs/fastTopics/prepared_data_YorubaOnly_genesExpressedInMoreThan10Cells.RData")
cat(sprintf("Loaded %d x %d counts matrix.\n",nrow(counts),ncol(counts)))

# LOAD PRE-FITTED MODEL
# ---------------------
if (prefit.file == "auto")
  prefit.file <- sprintf("prefit-k=%d.rds",k)
prefit.file <- file.path(".",prefit.file)
cat(sprintf("Loading pre-fitted model from %s\n",prefit.file))
fit0 <- readRDS(prefit.file)$fit

# FIT POISSON NON-NEGATIVE MATRIX FACTORIZATION
# ---------------------------------------------
# Now we are ready to perform the main model-fitting step.
cat("Fitting Poisson NMF to count data.\n")
control <- list(extrapolate = extrapolate,nc = nc)
if (method != "ccd")
  control$numiter <- 4
timing <- system.time({
  fit <- fit_poisson_nmf(counts,fit0 = fit0,numiter = numiter,
                         method = method,control = control)
})
cat(sprintf("Computation took %0.2f seconds.\n",timing["elapsed"]))

# SAVE RESULTS
# ------------
cat("Saving results.\n")
saveRDS(list(k = k,method = method,control = control,fit = fit),
        file = outfile)

# SESSION INFO
# ------------
print(sessionInfo())
