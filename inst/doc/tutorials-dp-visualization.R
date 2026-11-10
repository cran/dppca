## ----pca-setup, include=FALSE-------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.align = "center",
  fig.width = 10,
  fig.height = 7,
  message = FALSE,
  warning = TRUE,
  error = FALSE,
  cache = FALSE
)

## ----pca-data-----------------------------------------------------------------
library(dppca)
data("vowel", package = "dppca")
X <- vowel

dim(X)
names(X)

## ----pca-privacy--------------------------------------------------------------
privacy <- privacy_control(eps = 10, delta = 1e-4)
privacy$total
privacy$budgets

## ----pca-fit------------------------------------------------------------------
set.seed(123)
pca_fit <- dp_pca(
  X,
  privacy = privacy,
  scree = list(
    k = 4,
    method = "clipped",
    control = clipped_control(C_clip = 3)
  ),
  score = list(method = "sparse", bins = c(9, 9)),
  axes = c(1, 2),
  group = "Class"
)

pca_fit

## ----pca-summary--------------------------------------------------------------
pca_summary <- summary(pca_fit)
pca_summary

## ----pca-metadata-privacy-----------------------------------------------------
pca_fit$metadata$privacy$total
pca_fit$metadata$privacy$budgets

## ----pca-default-plot, fig.alt="Result of DP-PCA"-----------------------------
plot(pca_fit)

## ----pca-overview, eval=FALSE-------------------------------------------------
# set.seed(456)
# pca_plots <- plot(
#   pca_fit,
#   display = "all",
#   scree = list(
#     type = "pve",                # "pve" or "scree"
#     plot_control = NULL
#   ),
#   score = list(
#     type = "sample",             # "histogram" (default) or "sample"
#     plot_control = NULL
#   ),
#   loading = list(
#     type = "vector",            # "vector" (default), "point", or "heatmap"
#     heatmap_components = NULL,
#     plot_control = NULL
#   ),
#   variable = list(
#     plot_control = NULL
#   ),
#   biplot = list(
#     alpha = 0,
#     labels = TRUE,
#     plot_control = NULL
#   ),
#   sampling = sampling_control(  # Shared by score and biplot
#     method = "uniform",
#     sample_size = NULL,
#     bandwidth_scale = NULL
#   ),
#   center = TRUE,                # Shared by score and biplot
#   variables = 10,               # Shared by loading, variable and biplot
#   base_size = 12
# )

## ----pca-save, eval=FALSE-----------------------------------------------------
# # One figure
# ggplot2::ggsave(
#   "vowel-private-biplot.png",
#   plot = pca_plots$private$plots$biplot,
#   width = 7, height = 6, dpi = 300
# )
# 
# # One complete saved page
# grDevices::pdf("vowel-private-pca.pdf", width = 12, height = 8.5)
# grid::grid.newpage()
# grid::grid.draw(pca_plots$private$page)
# grDevices::dev.off()
# 
# # The fit can be saved separately for a later R session.
# saveRDS(pca_fit, "vowel-pca-fit.rds")

