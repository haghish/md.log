clean.call = function(x) {
  z <- strsplit(paste(x, collapse="\t"), "\t")[[1]]
  switch(z[1],
         "lapply" = z[3],
         "sapply" = z[3],
         "do.call" = z[2],
         "function" = "FUN",
         "source" = "###",
         "eval.with.vis" = "###",
         z[1]
  )
}
