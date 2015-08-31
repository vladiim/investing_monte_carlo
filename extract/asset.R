extract.asset <- function(asset) {
  d <- Quandl(paste0('YAHOO/', asset))
  write.csv(d, paste0(DATA_ACTUAL_FOLDER, '/', tolower(asset), '.csv'))
}

extract.assetVLC <- function() extract.asset(VLC)
# Vanguard® MSCI Australian Large Companies Index ETF ASX:VLC
# allocation 0.0749
