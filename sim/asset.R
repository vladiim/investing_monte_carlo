sim.assetRs   <- function(asset) sim.asset(asset, 'rs')
sim.assetFmkl <- function(asset) sim.asset(asset, 'fmkl')

# p c(rs, fmkl)
sim.asset <- function(asset, p) {
  n <- 10000000 # days to simulate
  d <- transform.assetLambdaParams(asset)
  sim.assetSample(d, n, p)
}

sim.assetSample <- function(d, n, p) {
  rgl(n = n, lambda1 = sim.assetGetLambda(d, p, 'mean'),
      lambda2 = sim.assetGetLambda(d, p, 'variance'),
      lambda3 = sim.assetGetLambda(d, p, 'skewness'),
      lambda4 = sim.assetGetLambda(d, p, 'kurtosis'), param = p)
}

sim.assetGetLambda <- function(d, p, l) {
  filter(d, param == p, lambda == l)$value
}
