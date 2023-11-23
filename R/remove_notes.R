#' Remove notes from DfT publication table headers
#' @name remove_notes
#' @param data Data frame with column names
#' @param trim Logical - TRUE to trim whitespace after removing notes, otherwise FALSE, default is TRUE.
#' @description This will have no effect if the data frame does not contain notes in the header.
#' The function identifies a note as anything inside square brackets [], check the number of notes removed in the message is as you expect.
#' @importFrom dplyr rename_with setdiff
#' @importFrom magrittr "%>%"
#' @importFrom stringr str_replace str_trim
#' @export

remove_notes <- function(data, trim = TRUE) {

  #Get list of column names before removing notes
  names_before <- names(data)

  #Remove [note x] from column names

  d <- dplyr::rename_with( #Apply this to all columns
    data, ~ stringr::str_replace( #Take the data as an argument, and replace
      ., "\\[.*", "") #Starting from a left square bracket, remove all text afterwards
  )

  if(trim == TRUE) {
    #Trim whitespace
    d <- d %>%
      dplyr::rename_with(stringr::str_trim) #Remove whitespace from all columns
  }

  #Get list of column names after removing notes
  names_after <- names(d)

  #Get number of column names changed and display
  n_changes <- length(setdiff(names_before, names_after))
  message(paste0(n_changes, " note(s) were removed."))

  return(d)
}
