# source('init.r')

# ----------- # # ----------- # # ----------- #
# DEPENDENCIES

library( reshape )
library( knitr )
library( markdown )
library( ggplot2 )
library( scales )
library( dplyr )
library( RColorBrewer )
library( Quandl )
library( xts )
library( GLDEX )
library( memoise )
# library( quantmod )

# ----------- # # ----------- # # ----------- #
# SET UP

# helper functions

loadDir <- function( dir ) {
  if ( file.exists( dir ) ) {
    files <- dir( dir , pattern = '[.][rR]$' )
    lapply( files, function( file ) loadFile( file, dir ) )
  }
}

loadFile <- function( file, dir ) {
  filename <- paste0( dir, '/', file )
  source( filename )
}

setReportingWd <- function() {
  if( basename( getwd() ) == 'templates' ) {
    setwd( '../../' )
  }
}

knitrGlobalConfig <- function() {
  opts_chunk$set( fig.width = 14, fig.height = 6,
    fig.path = paste0( getwd(), '/reports/output/figures/',
    set_comment = NA ) )
}

setEnvVars <- function() {
  source('env.R')
}

# Config env
setReportingWd()
knitrGlobalConfig()
setEnvVars()
set.seed(100)

Quandl.auth(Sys.getenv('QUANDL'))

# Constants
RS   <- 'rs'
FMKL <- 'fmkl'

MEAN     <- 'mean'
VARIANCE <- 'variance'
SKEWNESS <- 'skewness'
KURTOSIS <- 'kurtosis'

YEARS_TO_SIMULATE <- 40
DAYS_TO_SIMULATE  <- 365 * YEARS_TO_SIMULATE

DATA_ACTUAL_FOLDER <- 'data/actual'

VLC  <- 'ASX_VLC_AX' # ASX:VLC Vanguard® MSCI Australian Large Companies Index ETF
VSO  <- 'ASX_VSO_AX' # ASX:VSO Vanguard® MSCI Australian Small Companies Index ETF
VTS  <- 'ASX_VTS_AX' # ASX:VTS Vanguard® US Total Market Shares Index ETF
VEU  <- 'ASX_VEU_AX' # ASX:VEU Vanguard® All-World ex-US Shares Index ETF
VGE  <- '' # ASX:VGE Vanguard® FTSE Emerging Markets Shares ETF
IJH  <- 'AX_IJH' # ASX:IJH iShares Core S&P Mid-Cap ETF
VGB  <- '' # ASX:VGB Vanguard® Australian Government Bond Index ETF
ILB  <- 'SPBDAIBT' # ASX:ILB iShares Government Inflation ETF
REIT <- '' # 'INDEX_WGREIT' # Global REIT, to match AusSuper's REIT
FIX  <- '' # Int fixed securities, to match AusSuper's internation fixed

AUS_SECS <- c(VLC, VSOK VTS, VEU, IJH, ILB)

# Load code
dirs <- c( 'extract', 'load', 'transform', 'graphs', 'sim', 'lib' )
lapply( dirs, loadDir )
source( './reports/run.R' )

# No scientific notation
options( scipen = 999 )
