## ----loading-setup, include=FALSE---------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.align = "center",
  message = FALSE,
  warning = TRUE,
  error = FALSE,
  cache = FALSE
)

## ----loading-data-------------------------------------------------------------
library(dppca)
data("gau", package = "dppca")

X <- gau
dim(X)

## ----loading-privacy----------------------------------------------------------
loading_privacy <- privacy_control(
  eps = 3,
  delta = 1e-4
)

## ----loading-fit--------------------------------------------------------------
set.seed(123)
loading_fit <- dp_loading(
  X,
  privacy = loading_privacy,
  non_private = TRUE
)

loading_fit

## ----loading-inspect----------------------------------------------------------
dim(loading_fit$directions)
round(loading_fit$directions[1:6, 1:3, drop = FALSE], 3)

## ----loading-summary----------------------------------------------------------
summary(loading_fit)

## ----loading-vector, fig.width=10, fig.height=4.5, out.width="100%", fig.alt="Comparison of non-private and differentially private PCA direction coefficients shown as variable arrows."----
vector_plot <- plot(
  loading_fit,
  type = "vector"
)

## ----loading-all-plots, fig.width=12, fig.height=7.5, out.width="100%", fig.alt = "Non-private and private PCA direction coefficients shown in vector, point, and heatmap plots."----
loading_plots <- plot(loading_fit)

## ----loading-select-pcs, eval=FALSE, fig.alt = "Selected PCA direction coefficients displayed using vector and heatmap plots."----
# plot(
#   loading_fit,
#   type = c("vector", "heatmap"),
#   axes = c(1, 3),
#   heatmap_components = 1:4,
#   variables = 1:8  # Alternatively, select by name using paste0("V", 1:8)
# )

## ----loading-custom, fig.alt = "Customized visualization of differentially private PCA direction coefficients."----
custom_plot <- plot(
  loading_fit,
  type = "point",
  axes = c(1, 2),
  variables = 1:8,
  plot_control = loading_plot_control(
    nonprivate_color = "black",
    private_color = "navy",
    point_size = 3,
    label_size = 3.5,
    base_size = 12,
    title_size = 13,
    private_title = "Private directions"
  )
)

