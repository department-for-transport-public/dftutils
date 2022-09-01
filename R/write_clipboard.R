#' Copy data to an appropriately-sized clipboard where available
#
#' @param df a dataframe object
#' @export
#' @importFrom utils object.size write.table


writeClipboard <- function(df){

  if(Sys.info()['sysname'] != "Windows"){
    #Fail if not running on windows
    stop("Writing to clipboard does not work on Cloud instances of R.
         Please use the write.csv() function to save your data as a csv instead")
  }else{

  #Set size of clipboard depending on size of object
  size <- object.size(df) * 2
  # Copy a data.frame to clipboard
  write.table(df, paste0("clipboard-",
                         formatC(size, format = "f", digits = 0)),
              sep = "\t", row.names = FALSE, dec = ".")
  message("Object copied to clipboard")
  }
}
