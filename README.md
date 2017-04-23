# md.log : producing Markdown log files with function call in R


**md.log** is an R package for producing very clean log files in Markdown format. The main 
aim of the package is to provide the tools for producing very clean log files, that also 
include a built-in function call argument, allowing to trace from which function the current log 
is being printed. 

Installing
----------

To install **`md.log`** package in R:

```js
library(devtools)
install_github("haghish/md.log")
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
  Center for Medical Biometry and Medical Informatics    
  University of Freiburg, Germany       
  _and_   
  Department of Mathematics and Computer Science   
  Univesity of Southern Denmark, Odense, Denmark    

  _haghish@imbi.uni-freiburg.de_  
  _http://www.haghish.com/markdoc_  
  _[@Haghish](https://twitter.com/Haghish)_   
  
  
  
 
