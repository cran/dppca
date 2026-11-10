## ----score-setup, include=FALSE-----------------------------------------------
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

## ----score-data---------------------------------------------------------------
library(dppca)
data("gau", package = "dppca")

X <- gau
dim(X)

## ----score-privacy------------------------------------------------------------
score_privacy <- privacy_control(
  eps = 6,
  delta = 1e-4
)

## ----score-fit----------------------------------------------------------------
set.seed(123)
score_fit <- dp_score(
  X,
  privacy = score_privacy,
  bins = c(10, 10),
  method = c("add", "sparse"),
  axes = c(1, 2),
  non_private = FALSE
)

score_fit

## ----score-summary------------------------------------------------------------
score_summary <- summary(score_fit)
score_summary

## ----score-values-------------------------------------------------------------
score_fit$frame
head(score_fit$add)
sum(score_fit$add$prob)
score_fit$metadata$method
score_fit$metadata$privacy

## ----score-histogram, fig.alt="Private two-dimensional PCA score histogram with shaded rectangular bins."----
histogram_plot <- plot(
  score_fit,
  type = "histogram"
)

## ----score-center, eval=FALSE, fig.alt="Private PCA score histogram and synthetic samples displayed without shifting the private frame center to the origin."----
# set.seed(321)
# plot(score_fit, type = c("histogram", "sample"), center = FALSE)

## ----score-sample, fig.alt="Synthetic PCA score points sampled from the private histogram."----
set.seed(321)
sample_plot <- plot(
  score_fit,
  type = "sample",
  sampling_control = sampling_control(
    method = "uniform",
    sample_size = 500,
    bandwidth_scale = 0.1
  )
)

## ----score-customize, fig.alt="Private additive score histogram with customized labels and shading."----
plot(
  score_fit,
  type = "histogram",
  plot_control = score_plot_control(
    color = "#1F4E79",
    add_title = "Estimated distribution on PC1 and PC2",
    xlab = "Private PC1 score",
    ylab = "Private PC2 score",
    hist_alpha_range = c(0, 0.85),
    base_size = 13,
    title_size = 14
  )
)

## ----score-group-data---------------------------------------------------------
data("gau_g", package = "dppca")
X_group <- gau_g

dim(X_group)
table(X_group$group)

## ----score-group-fit----------------------------------------------------------
set.seed(456)
group_fit <- dp_score(
  X_group,
  privacy = score_privacy,
  bins = c(10, 10),
  group = "group",
  non_private = FALSE
)

summary(group_fit)
names(group_fit$groups)

## ----score-group-default, fig.alt="Group-wise differentially private score histogram"----
plot(group_fit)

## ----score-group-histogram, fig.alt="Group-wise differentially private score histogram overlays with five custom group colors"----
group_colors <- c(
  group1 = "#0072B2", group2 = "#D55E00", group3 = "#009E73",
  group4 = "#CC79A7", group5 = "#E69F00"
)

group_hist_plot <- plot(
  group_fit,
  sampling_control = sampling_control(
    method = "uniform", sample_size = 500
  ),
  plot_control = score_plot_control(
    group_colors = group_colors,
    hist_alpha_range = c(0, 0.75)
  )
)

