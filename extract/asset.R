extract.asset <- function(asset) {
  d <- Quandl(paste0('YAHOO/', asset))
  write.csv(d, paste0(DATA_ACTUAL_FOLDER, '/', tolower(asset), '.csv'))
}
