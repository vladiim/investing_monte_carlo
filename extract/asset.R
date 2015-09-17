extract.asset <- function(asset) {
  d <- Quandl(paste0('YAHOO/', asset))
  write.csv(d, paste0(DATA_ACTUAL_FOLDER, '/', tolower(asset), '.csv'))
}

extract.assets <- function() {
  getSymbols(SYMBOLS, from='1900-01-01')
  d <- list()
  for(symbol in SYMBOLS) d[[symbol]] <- Ad(get(symbol))
  d        <- do.call(cbind, d)
  names(d) <- tolower(substr(names(d), 1, 3))
  d        <- data.frame(date = time(d), d, check.names = FALSE, row.names = NULL)
  d        <- melt(d, id = 'date')
  names(d) <- c('date', 'stock', 'price')
  d
}

extract.assetsAndSave <- function() {
  d <- extract.assets()
  write.csv(d, paste0(DATA_ACTUAL_FOLDER, '/assets.csv'))
}
