## ----gs-setup, include=FALSE--------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>", fig.align = "center",
  fig.width = 7, fig.height = 5,
  message = FALSE, warning = TRUE, error = FALSE, cache = FALSE
)

## ----gs-install-cran, eval=FALSE----------------------------------------------
# install.packages("dppca")

## ----gs-install-github, eval=FALSE--------------------------------------------
# install.packages("remotes")  # Only needed once
# remotes::install_github("yejinjo0220/dppca")

## ----gs-load------------------------------------------------------------------
library(dppca)

## ----gs-gaussian-data---------------------------------------------------------
data("gau", package = "dppca")
data("gau_g", package = "dppca")

dim(gau)
dim(gau_g)
head(gau[, 1:4, drop = FALSE])
table(gau_g$group)

## ----gs-vowel-data------------------------------------------------------------
data("vowel", package = "dppca")

numeric_columns <- vapply(vowel, is.numeric, logical(1))
dim(vowel)
names(vowel)[numeric_columns]
names(vowel)[!numeric_columns]
table(vowel$Class)

## ----gs-default-privacy-------------------------------------------------------
privacy <- privacy_control(
  eps = 6,
  delta = 1e-4
)

## ----gs-inspect-budget--------------------------------------------------------
privacy$total
privacy$budgets

## ----gs-custom-split----------------------------------------------------------
pca_privacy_custom <- privacy_control(
  eps = 6,
  delta = 1e-4,
  split = c(loading = 0.2, scree = 0.4, score = 0.4)
)

pca_privacy_custom$budgets

## ----gs-custom-score-split----------------------------------------------------
score_privacy_custom <- privacy_control(
  eps = 6,
  delta = 1e-4,
  split = c(loading = 0.4, score = 0.6)
)

score_privacy_custom$budgets

## ----gs-absolute-budgets------------------------------------------------------
pca_privacy_absolute <- privacy_control(
  loading = c(eps = 2, delta = 2e-5),
  scree   = c(eps = 3, delta = 3e-5),
  score   = c(eps = 5, delta = 5e-5)
)

pca_privacy_absolute$total

