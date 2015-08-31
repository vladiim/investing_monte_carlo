sim.assetRs   <- function(asset) sim.asset(asset, RS)
sim.assetFmkl <- function(asset) sim.asset(asset, FMKL)

# p == RS or FMKL
sim.asset <- function(asset) {
  d           <- transform.asset(asset)
  max_date    <- max(index(d))
  last_return <- as.vector(d[max_date]$return)
  lambda      <- transform.assetLambdaParams(asset)
  result      <- sim.assetResult(max_date, lambda)
  sim.assetCumSum(result, last_return)
}

sim.assetResult <- function(max_date, lambda) {
  data.frame(
    date     = max_date + 1:DAYS_TO_SIMULATE,
    rs_sim   = sim.assetSample(lambda, RS),
    fmkl_sim = sim.assetSample(lambda, FMKL)
  )
}

sim.assetCumSum <- function(d, last_return) {
  d$rs_sim[1]   <- d$rs_sim[1] + last_return
  d$fmkl_sim[1] <- d$fmkl_sim[1] + last_return
  d$rs_return   <- cumsum(d$rs_sim)
  d$fmkl_return <- cumsum(d$fmkl_sim)
  d
}

sim.assetSample <- function(d, p) {
  rgl(n = DAYS_TO_SIMULATE,
      lambda1 = sim.assetGetLambda(d, p, MEAN),
      lambda2 = sim.assetGetLambda(d, p, VARIANCE),
      lambda3 = sim.assetGetLambda(d, p, SKEWNESS),
      lambda4 = sim.assetGetLambda(d, p, KURTOSIS), param = p)
}

sim.assetGetLambda <- function(d, p, l) {
  filter(d, param == p, lambda == l)$value
}
