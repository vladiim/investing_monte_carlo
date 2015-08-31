graph.assetGLD <- function(asset) {
  d   <- transform.asset(asset)
  fit <- transform.assetLambda(asset)
  fun.plot.fit(fit.obj = fit,data = as.vector(d$diff), param = c('rs', 'fmkl'))
}
