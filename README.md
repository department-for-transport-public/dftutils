# dftutils package

The purpose of this package is to create a package of commonly used, simple utility functions for people within DfT to make use of in analytical code. All of the functions in this code are designed to work in any project, and are general functions that would be of use to a wide range of people.

## Installation

The package can be installed directly from Github using the remotes install_github call

```
install.packages("remotes")
remotes::install_github("department-for-transport-public/dftutils")
```

## Overview

The package contains the following functions:

### Excel data table processing

* `addSuperScriptToCell`: function to present text as superscript values in Excel workbooks.
* `remove_notes`: Remove notes from headers of DfT tables

### ODS file functions

* `clean_metadata`: Remove personal information from the metadata of an ODS file and add tags if you want.
* `remove_colours`: Drop font colours from an ODS file in favour of using automatic font colour.
* `convert_to_ods`: Automatic conversion of xlsx files to ods in Cloud R.

### Sharepoint

* `list_sharepoint_drives`: Find the names of Sharepoint drives on your Sharepoint site.
* `import_sharepoint`: Import a file stored on Sharepoint into Cloud R for use.
* `export_sharepoint` and `export_sharepoint_file`: Export R data objects and files to Sharepoint.

### Misc

* `recent_file`: Search function to find most recently updated file in a given directory.
* `round`: Mathematical rounding function which rounds values which end in 5 up, in contrast to the default behaviour of R (round to even).
* `writeClipboard`: Write a data frame to an appropriately sized clipboard in Windows.
* `sqlConnect`: Connection string to a SQL server using odbc.


