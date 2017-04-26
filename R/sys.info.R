sys.info <- function() {
  sysinf <- Sys.info()
  os <- sysinf['sysname']
  release = sysinf['release']
  cpu = sysinf['machine']

  # Setting for Mac OS X
  if (!is.null(sysinf)){
    if (os == 'Darwin') {
      str = unlist(strsplit(sessionInfo()$running, split = " "))
      os = paste("Mac OSX", str[2])
      release = str[3]
      #release = as.numeric_version(system("sw_vers -productVersion", intern = TRUE))
    }
  }

  else { ## mystery machine
    os <- .Platform$OS.type
    if (grepl("^darwin", R.version$os))
      str = unlist(strsplit(sessionInfo()$running, split = " "))
      os = paste("Mac OSX", str[2])
      release = str[3]
    if (grepl("linux-gnu", R.version$os))
      os <- "Linux"
  }
  return(list(os=os, release=release, cpu=cpu))
}
