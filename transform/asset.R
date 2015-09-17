transform.assets <- function() {
  load.assets()
}

transform.assetsByDate <- function(filter_year = 2015) {
  transform.assets() %>%
    mutate(year = as.numeric(format(date, '%Y'))) %>%
    filter(year == filter_year) %>%
    select(-year)
}

# ----------- helper

transform.asset <- function(asset) {
  d           <- load.asset(asset)
  d$date      <- as.Date(d$date)
  d           <- xts(d$adjusted_close, d$date)
  names(d)[1] <- 'return'
  # d$diff      <- diff(log(d), lag = 1)
  d$diff      <- diff(d, lag = 1)
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
    param  = c(rep(RS, 4), rep(FMKL, 4)),
    lambda = rep(c(MEAN, VARIANCE, SKEWNESS, KURTOSIS), 2),
    value  = c(d[1, 1], d[2, 1], d[3, 1], d[4, 1], d[1, 2], d[2, 2], d[3, 2], d[4, 2])
  )
  d$param  <- as.character(d$param)
  d$lambda <- as.character(d$lambda)
  d
}

transform.assetLambdaParamsVLC <- function() transform.assetLambdaParams(VLC)
