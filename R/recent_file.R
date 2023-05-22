#' Find the most recently modified file in a folder
#' Can use a matching pattern to specify a specific file type or name.
#
#' @param filepath folder to search in to find most recent file
#' @param pattern an optional regular expression. Only file names which match
#' the regular expression will be returned.
#' @param recursive logical. Should the listing look inside subfolders in
#' the filepath? Defaults to FALSE.
#' @param ignore.case logical. Should pattern-matching be case-insensitive?
#' Defaults to FALSE
#'
#' @name recent_file
#' @export

recent_file <- function(filepath,
                        pattern = NULL,
                        recursive = FALSE,
                        ignore.case = FALSE){


  files <- list.files(filepath,
             pattern = pattern,
             recursive = recursive,
             full.names = TRUE,
             ignore.case = ignore.case)

  ##Drop any and all temp files
  files <- files[!grepl("[~][$]", files)]

  ##Get file info for listed files
  files <- file.info(files)

  ##Keep only most recent file
  row.names(files[files$mtime == max(files$mtime, na.rm = TRUE),])

}

