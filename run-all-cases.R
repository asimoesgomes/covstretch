source("project-setup.R")

source("cases/fdf-prep-delta.R")

if (!all_k) {
  load("results/fdf-deltas.Rdata")
} else {
  load("results/fdf-deltas-allk.Rdata")
}
source("cases/fdf-results.R")

source("cases/prep-results.R")
source("cases/general-example.R")
source("cases/vax_rates.R")
source("cases/lower-efficacy.R")
source("cases/lower-efficacy-delay.R")
source("cases/lower-efficacy-speedup-lim.R")

source("cases/kappa-impact.R") #impact of immunity loss (appendix)
source("cases/delay-impact.R")
source("cases/supply-impact.R")
source("cases/vrf.R")

source("cases/benefits.R")

fig_folder <- "figures"
width <- 6.5
source("cases/generate-figures.R")
