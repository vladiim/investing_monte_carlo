# ----------- helper

transform.asset <- function(asset) {
  d           <- load.asset(asset)
  d$date      <- as.Date(d$date)
  d           <- xts(d$adjusted_close, d$date)
  names(d)[1] <- 'return'
  d$diff      <- diff(log(d), lag = 1)
  d[-1] # Remove the NA in the first position
}

# ----------- asset specific

transform.assetVLC <- function() transform.asset(VLC)

# ----------- lambda values

transform.assetLambda <- memoise(function(asset) {
  d <- transform.asset(asset)
  v <- as.vector(transform.assetVLC()$diff)
  fun.data.fit.mm(v)
})

transform.assetLambdaParams <- function(asset) {
  d <- transform.assetLambda(asset)
  d <- data.frame(
    param  = c(rep('rs', 4), rep('fmkl', 4)),
    lambda = rep(c('mean', 'variance', 'skewness', 'kurtosis'), 2),
    value  = c(d[1, 1], d[2, 1], d[3, 1], d[4, 1], d[1, 2], d[2, 2], d[3, 2], d[4, 2])
  )
  d$param  <- as.character(d$param)
  d$lambda <- as.character(d$lambda)
  d
}

transform.assetLambdaParamsVLC <- function() transform.assetLambdaParams(VLC)
