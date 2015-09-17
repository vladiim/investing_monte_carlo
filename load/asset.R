load.asset <- function(asset) {
  d        <- read.csv(paste0('data/actual/', tolower(asset), '.csv'), header = TRUE, sep = ',', stringsAsFactors = FALSE)
  names(d) <- gsub('\\.', '_', tolower(names(d)))
  select(d, -x)
}

load.assetVLC <- function() load.asset(VLC)

load.assets <- function() {
  read.csv(paste0(DATA_ACTUAL_FOLDER, '/assets.csv')) %>%
    select(-X) %>%
    filter(!is.na(price)) %>%
    mutate(date = as.Date(date), price = as.numeric(price))
}
