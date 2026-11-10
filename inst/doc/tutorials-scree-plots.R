## ----scree-setup, include=FALSE-----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.align = "center",
  fig.width = 7,
  fig.height = 5,
  message = FALSE,
  warning = TRUE,
  error = FALSE,
  cache = FALSE
)

## ----scree-data---------------------------------------------------------------
library(dppca)
data("gau", package = "dppca")

X <- gau
dim(X)

## ----scree-privacy------------------------------------------------------------
scree_privacy <- privacy_control(
  eps = 6,
  delta = 1e-4
)

## ----scree-fit----------------------------------------------------------------
set.seed(123)
scree_fit <- dp_scree(
  X,
  k = 5,
  privacy = scree_privacy,
  method = "clipped",
  control = clipped_control(C_clip = 20),
  non_private = TRUE
)

scree_fit

## ----scree-summary------------------------------------------------------------
scree_summary <- summary(scree_fit)
scree_summary

## ----scree-values-------------------------------------------------------------
scree_fit$clipped$scree
scree_fit$clipped$pve
scree_fit$nonprivate$scree
scree_fit$metadata$privacy

## ----scree-default-plots, fig.width=12, fig.height=4.5, out.width="100%", results="hide", fig.alt="Private and ordinary PCA PVE and scree plots"----
plot(scree_fit)

## ----scree-select-views, eval=FALSE-------------------------------------------
# plot(scree_fit, type = "pve")
# plot(scree_fit, type = "scree")

## ----scree-clipped-control----------------------------------------------------
clipped_set <- clipped_control(C_clip = 20)
clipped_set

## ----scree-pmwm---------------------------------------------------------------
pmwm_set <- pmwm_control(
  a = 0,
  b = 50,
  trim_const = 10,
  eta = 0.01
)

## ----scree-pmwm-fit, eval=FALSE-----------------------------------------------
# set.seed(123)
# pmwm_fit <- dp_scree(
#   X,
#   k = 5,
#   privacy = scree_privacy,
#   method = "pmwm",
#   control = pmwm_set,
#   non_private = TRUE
# )
# 
# summary(pmwm_fit)
# plot(pmwm_fit, type = "pve")

## ----scree-huber--------------------------------------------------------------
huber_set <- huber_control(
  k_min_m2 = -10,
  k_max_m2 = 10,
  m2_frac = 0.25
)

## ----scree-huber-fit, eval=FALSE----------------------------------------------
# set.seed(123)
# huber_fit <- dp_scree(
#   X,
#   k = 5,
#   privacy = scree_privacy,
#   method = "huber",
#   control = huber_set,
#   non_private = TRUE
# )
# 
# summary(huber_fit)
# plot(huber_fit, type = "pve")

## ----scree-method-comparison--------------------------------------------------
set.seed(123)
scree_comparison <- dp_scree(
  X,
  k = 5,
  privacy = scree_privacy,
  method = c("clipped", "pmwm", "huber"),
  control = list(
    clipped = clipped_set,
    pmwm = pmwm_set,
    huber = huber_set
  ),
  non_private = TRUE
)

summary(scree_comparison)

## ----scree-method-comparison-plot, results="hide", fig.alt="PVE comparison of clipped, PMWM, Huber, and ordinary PCA"----
plot(scree_comparison, type = "pve")

## ----scree-reuse-direct, eval=FALSE-------------------------------------------
# # Estimate private PC directions.
# loading_fit <- dp_loading(
#   X,
#   eps = 3,
#   delta = 5e-5
# )
# 
# # Specify the actual loading budget and the scree budget.
# reuse_privacy <- privacy_control(
#   loading = c(eps = 3, delta = 5e-5),
#   scree   = c(eps = 3, delta = 5e-5)
# )

## ----scree-reuse-split, eval=FALSE--------------------------------------------
# reuse_privacy <- privacy_control(
#   eps = 6,
#   delta = 1e-4,
#   split = c(loading = 0.5, scree = 0.5)
# )
# 
# # Estimate private PC directions using the allocated loading budget.
# loading_budget <- reuse_privacy$components$loading
# 
# loading_fit <- dp_loading(
#   X,
#   eps = loading_budget[["eps"]],
#   delta = loading_budget[["delta"]]
# )

## ----scree-reuse-directions, eval=FALSE---------------------------------------
# scree_reused <- dp_scree(
#   X,
#   k = 5,
#   privacy = reuse_privacy,
#   method = "clipped",
#   control = clipped_control(C_clip = 20),
#   V_dp = loading_fit$directions,
#   non_private = FALSE
# )
# 
# summary(scree_reused)

## ----scree-custom-plot, results="hide", fig.alt="Customized PVE plot comparing private and ordinary PCA"----
plot(
  scree_fit,
  type = "pve",
  plot_control = scree_plot_control(
    title = "PVE among the first five PCs",
    col = c(nonprivate = "grey30", clipped = "#1F4E79"),
    legend_labels = c(nonprivate = "Ordinary PCA", clipped = "Clipped DP"),
    lwd = 2,
    point_cex = 1.2,
    cex_main = 1.2,
    legend_position = "topright"
  )
)

