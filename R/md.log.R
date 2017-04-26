#' @title md.log
#' @usage md.log(msg, file = "", append = FALSE, sys.info = TRUE,
#' section="monospace", level="", trace=TRUE, date=FALSE,
#' time=FALSE,datetime.fmt="\%Y-\%m-\%d \%H:\%M:\%S")
#'
#' @description produces Markdown log files with an optional argument
#' to include the function call inside the Markdown log file.
#'
#' @param msg the text that is to be printed in the log file. By default
#' \code{msg} is printed as monospace code inside the Markdown log,
#' unless the \code{section} argument is used to change this behavior.
#'
#' @param file A connection, or a character string naming the file to
#' print to. If \code{""} (the default), the \code{msg} is printed to the
#' standard output connection or the previously defined log file
#'
#' @param append logical. Only used if the argument file is the name
#' of file (and not a connection). If \code{TRUE}, output will be
#' appended to file; otherwise, it will overwrite the contents of file.
#'
#' @param sys.info logical. Only used Only used if the argument file is the name
#' of file (and not a connection). If \code{TRUE}, the system information,
#' R version, and date and time will be printed at the outset of the
#' log file.
#'
#' @param section styles the \code{msg} argument with Markdown syntax
#' and it can be \code{monospace}, \code{section}, \code{subsection},
#' or \code{paragraph}. the default value is \code{monospace}.
#'
#' @param level is a marker that is printed at the beginning of each
#' \code{monospace} massage and cannot be more than seven characters
#' long. this argument can be used to distinct massages with warnings
#' or errors
#'
#' @param trace logical. If \code{TRUE}, the function call is included
#' before each \code{msg}
#'
#' @param date logical. if \code{TRUE}, the current date is included
#' before each \code{msg}
#'
#' @param time logical. if \code{TRUE}, the current time is included
#' before each \code{msg}
#'
#' @param datetime.fmt specifies the format of date and time arguments
#' and by default is \code{"\%Y-\%m-\%d \%H:\%M:\%S"}. whitespace should
#' only be used to separate the date and time formats
#'
#' @examples
   # \dontrun{
#'# --------------------------------------------------------------------
#'# Testing the md.log package
#'# ====================================================================
#'
#'child = function() {
#'   md.log("current function", level="dope!")
#'}
#'
#'parent = function(){
#'  md.log("step 2")
#'  child()
#'}
#'
#'grandparent = function() {
#'  md.log("step 3")
#'  parent()
#'}
#'
#' # The main test function that produces the log and calls the other functions
#'md.log.test = function() {
#'  require(md.log)
#'  md.log("Initiating a new Markdown log", file="markdown.log")
#'
#'  # starting the logs
#'  md.log("a simple MONOSPACE log")
#'  md.log("Adding a level", level="notice")
#'  md.log("level makes you pay attention to a particular line")
#'
#'  # add a subsection and a paragraph in the log
#'  md.log("This is a subsection", section="subsection")
#'  md.log("This is a text paragraph for detailed explanation...", section="paragraph")
#'
#'  # testing the function call
#'  child()
#'  md.log("so far so good! now let's test a more complex nest")
#'  grandparent()
#'}
#'
#'md.log.test()
   # }





#' @author E. F. Haghish \cr
#' Institute for Community Medicine \cr
#' University of Greifswald, Germany \cr
#' \email{haghish@uni-greifswald.de} \cr
#' and \cr
#' Institute for Medical Informatics (IMBI) \cr
#' University of Freiburg, Germany \cr
#' \email{haghish@imbi.uni-freiburg.de} \cr
#'
#' @importFrom futile.logger layout.format
#' @importFrom futile.logger flog.appender
#' @importFrom futile.logger appender.file
#' @importFrom futile.logger flog.info
#' @importFrom futile.logger flog.threshold
#' @importFrom futile.logger flog.layout
#' @importFrom utils head
#' @importFrom utils sessionInfo
#' @export

# packrat::opts$external.packages(c("devtools", "roxygen2"))

md.log = function(msg,
                   file = "",
                   append = FALSE,
                   sys.info = TRUE,
                   section="monospace",
                   level="",
                   trace=TRUE,
                   date=FALSE,
                   time=FALSE,
                   datetime.fmt="%Y-%m-%d %H:%M:%S") {

  # Prepare the package and get the trace path
  # ------------------------------------------------------------------
  path = trace.call()
  list = path[-length(path)]

  # Write to a new file or append to the previous log
  # ------------------------------------------------------------------
  if (file != "") {
    if (!append) {
      unlink(file)
    }
    flog.appender(appender.file(file))
    if (sys.info) {
      info = sys.info()
      flog.layout(layout.format('~m'))                                # Only log the message
      flog.info(msg)
      flog.info(paste(paste(replicate(nchar(msg), "="),collapse = ""),"\n", collapse = ""))
      flog.info('    Date and Time  :  %s', Sys.time())
      flog.info('    System         :  %s  %s  %s', info$os, info$release, info$cpu)
      flog.info('    R Version      :  %s \n\n' , R.Version()$version.string )
    }
  }

  # Write a header or text paragraph
  # ------------------------------------------------------------------
  else if (section != "monospace") {
    n = nchar(msg)
    flog.layout(layout.format('~m'))                                  # Only log the message
    if (section == "section") {
      flog.info("\n")
      flog.info(msg)
      flog.info(paste(paste(replicate(n, "="), collapse = ""),"\n", collapse = ""))
    } else if (section == "subsection") {
      flog.info("\n")
      flog.info(msg)
      flog.info(paste(paste(replicate(n, "-"), collapse = ""),"\n", collapse = ""))
    } else if (section == "paragraph") {
      flog.info(msg)
      flog.info("")
    }
  }

  # Write monospace text
  # ------------------------------------------------------------------
  else {
    datetime = unlist(strsplit(datetime.fmt, " "))
    date.fmt = datetime[1]
    time.fmt = datetime[2]

    if (level=="") {
      level = "       "
    }
    else {
      level = toupper(level)
      level = abbreviate(level, 7, strict = TRUE)
      n = nchar(level)
      if (n < 7) {
        level = paste(level, paste(replicate(7-n-1, " "), collapse = ""))
      }
    }

    if (date) {
      date = date.fmt
    }
    else date = NULL

    if (time) {
      time = time.fmt
    }
    else time = NULL

    if (!is.null(date) | !is.null(time)) {
      dateTime = trimws(paste(date, time))
      dtsymbol = " [~t]"
    }
    else {
      dateTime = ""
      dtsymbol = ""
    }

    if (trace) {
      fsymbol = ""
      p = paste(paste(list, collapse=" > "),":", sep = "")
      msg = paste(p, msg)
    }
    else {
      fsymbol = " ~f:"
    }

    format = paste("    ", level, dtsymbol, fsymbol, " ~m", sep = "")
    flog.layout(layout.format(format, datetime.fmt=dateTime))
    flog.info('%s' , msg )
  }
}

