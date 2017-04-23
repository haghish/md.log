trace.call = function(..., call=sys.calls()){
  call <- sapply(call, clean.call)
  call[grepl("\\<function\\>", call)] <- "FUN"
  call <- call[!grepl("(###|FUN)", call)]
  call <- head(call, -1)
  return(call)
}
