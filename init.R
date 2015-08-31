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
DATA_ACTUAL_FOLDER <- 'data/actual'
VLC                <- 'ASX_VLC_AX'

# Load code
dirs <- c( 'extract', 'load', 'transform', 'graphs', 'sim', 'lib' )
lapply( dirs, loadDir )
source( './reports/run.R' )

# No scientific notation
options( scipen = 999 )
