trace.call = function(..., call=sys.calls()){
  call <- sapply(call, clean.call)
  call[grepl("\\<function\\>", call)] <- "FUN"
  call <- call[!grepl("(###|FUN)", call)]
  call <- head(call, -1)

  # avoid some functions in tryCatch
  # ------------------------------------------------------------------
  call = call[!call %in% c("tryCatchList", "tryCatchOne", "doTryCatch",
                           c("withVisible","eval","eval" ))]

  return(call)
}
