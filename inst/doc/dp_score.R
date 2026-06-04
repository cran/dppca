## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.align = "center"
)

## ----eval = FALSE-------------------------------------------------------------
# library(dppca)
# 
# data(gau, package = "dppca")
# 
# set.seed(123)
# score_plot <- dp_score_plot(
#   X = gau,
#   eps = 5,
#   delta = 1e-5,
#   bins = c(15, 15),
#   method = c("add", "sparse"),
#   axes = c(1, 2)
# )
# 
# score_plot$plot$all

## ----eval = FALSE-------------------------------------------------------------
# library(dppca)
# 
# data(gau_g, package = "dppca")
# 
# set.seed(123)
# score_plot_group <- dp_score_plot_group(
#   X = gau_g,
#   group = "group",
#   eps = 3,
#   delta = 1e-5,
#   bins = c(15, 15),
#   method = c("add", "sparse")
# )
# 
# score_plot_group$plot$all

