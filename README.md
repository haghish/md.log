<!-- [![](https://cranlogs.r-pkg.org/badges/md.log)](https://cran.r-project.org/package=md.log) -->


<a href="https://github.com/haghish/md.log"><img src='man/figures/logo.PNG' align="right" height="200" /></a>

# md.log : producing Markdown log files with function call in R

[![CRAN version](http://www.r-pkg.org/badges/version/md.log?color=258076)](https://cran.r-project.org/package=md.log)  [![](https://cranlogs.r-pkg.org/badges/grand-total/md.log?color=e8a0c6)](https://cran.r-project.org/package=md.log) [![](https://raw.githubusercontent.com/haghish/mlim/main/man/figures/manual.svg)](https://cran.r-project.org/web/packages/md.log/md.log.pdf)


**md.log** is an R package for producing very clean log files in Markdown format. The main 
aim of the package is to provide the tools for producing very clean log files, that also 
include a built-in function call argument, allowing to trace from which function the current log 
is being printed. 

Installing
----------

To install **`md.log`** package in R:

```js
devtools::install_github("haghish/md.log")
```


Converting the Markdown log to HTML
-----------------------------------

Once the log file is produced you can convert it to HTML as folloows

```js
library(knitr)
knit2html("./filename.log")
```

Example
-------

See the **test** directory inside the package for examples

Author
------
  **E. F. Haghish**    
  Department of Psychology    
  University of Oslo, Norway       

  _haghish@uio.no_  
  _http://www.haghish.com/stats_  
  _[@Haghish](https://twitter.com/Haghish)_   
  
  
  
 
