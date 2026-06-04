## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.align = "center"
)

## ----eval = FALSE-------------------------------------------------------------
# library(dppca)
# dp_scree(
#   X,
#   k = 3,
#   method = "clipped",
#   eps_total = 1,
#   delta_total = 1e-6,
#   center = TRUE,
#   standardize = FALSE,
#   control = clipped_control(
#     C_clip = 3
#   )
# )

## ----eval = FALSE-------------------------------------------------------------
# dp_scree(
#   X,
#   k = 3,
#   method = "huber",
#   eps_total = 1,
#   delta_total = 1e-6,
#   center = TRUE,
#   standardize = FALSE,
#   control = huber_control(
#     mu0 = 0,
#     eta0 = 1,
#     T = 50,
#     M = 20,
#     k_min_m2 = -40,
#     k_max_m2 = 40,
#     m2_frac = 1/4
#   )
# )

## ----eval = FALSE-------------------------------------------------------------
# dp_scree(
#   X,
#   k = 3,
#   method = "pmwm",
#   eps_total = 1,
#   delta_total = 1e-6,
#   center = TRUE,
#   standardize = FALSE,
#   control = pmwm_control(
#     beta = 1.01,
#     a = 0,
#     b = 10,
#     trim_const = 10,
#     eta = 0.01,
#     split_mode = TRUE
#   )
# )

## ----eval = FALSE-------------------------------------------------------------
# dp_scree_plot(
#   X,
#   k = 3,
#   dp_scree_method = "clipped",
#   eps_total = 1,
#   delta_total = 1e-6,
#   control = clipped_control(
#     C_clip = 3
#   )
# )

## ----eval = FALSE-------------------------------------------------------------
# dp_scree_plot(
#   X,
#   k = 3,
#   dp_scree_method = "all",
#   eps_total = 1,
#   delta_total = 1e-6,
#   center = TRUE,
#   standardize = FALSE,
#   control = list(
#     clipped = clipped_control(
#       C_clip = 3
#     ),
#     pmwm = pmwm_control(
#       beta = 1.01,
#       a = 0,
#       b = 10,
#       trim_const = 10,
#       eta = 0.01,
#       split_mode = TRUE
#     ),
#     huber = huber_control(
#       mu0 = 0,
#       eta0 = 1,
#       T = 50,
#       M = 20,
#       k_min_m2 = -40,
#       k_max_m2 = 40,
#       m2_frac = 1/4
#     )
#   )
# )

