#' Convert an Excel file to the equivalent ods object in Cloud R.
#' Note that this function will not work in local versions of R.
#' @param file name of an xlsx file to convert to ods
#' @param folder directory location of the xlsx file, and where the ods file
#' will save to. Defaults to the current working directory
#' @export
#' @name convert_to_ods

convert_to_ods <- function(file, folder = getwd()){

  if(Sys.info()['sysname'] != "Linux"){
    #Fail if not running on Linux
    stop("Conversion to ods only works on Cloud R.
         For Windows machines, use the odsconvertr package instead")
  }

  if(!dir.exists(suppressWarnings(normalizePath(folder)))){

    stop(folder, " does not exist")
  }

  if(!file.exists(suppressWarnings(normalizePath(file.path(folder, file))))){

    stop(file, " does not exist in the specified folder")
  }

  ##Pass command to system
  system(paste0("libreoffice --headless --convert-to ods --outdir ",
                "'",
                normalizePath(folder),
                "' '",
                normalizePath(file.path(folder, file)),
                "'"), ignore.stderr = TRUE)

}
