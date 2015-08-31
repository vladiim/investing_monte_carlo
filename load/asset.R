load.asset <- function(asset) {
  d        <- read.csv(paste0('data/actual/', tolower(asset), '.csv'), header = TRUE, sep = ',', stringsAsFactors = FALSE)
  names(d) <- gsub('\\.', '_', tolower(names(d)))
  select(d, -x)
}

load.assetVLC <- function() load.asset(VLC)
