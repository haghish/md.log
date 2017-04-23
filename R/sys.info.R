sys.info <- function() {
  sysinf <- Sys.info()
  os <- sysinf['sysname']
  release = sysinf['release']
  cpu = sysinf['machine']
  if (!is.null(sysinf)){
    if (os == 'Darwin') {
      os <- "OSX"
    }
  } else { ## mystery machine
    os <- .Platform$OS.type
    if (grepl("^darwin", R.version$os))
      os <- "OSX"
    if (grepl("linux-gnu", R.version$os))
      os <- "Linux"
  }
  return(list(os=os, release=release, cpu=cpu))
}
