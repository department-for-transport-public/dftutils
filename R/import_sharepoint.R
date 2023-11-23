#' Import a file from a specified Sharepoint location
#' @name import_sharepoint
#' @param file Name and location of the file you want to extract from sharepoint. Includes the extension and any folders after the drive name
#' @param site Name of sharepoint site you want to take a file from. Can be found in the URL of the Sharepoint location, e.g. for "departmentfortransportuk.sharepoint.com/sites/Rail", the site name would be Rail
#' @param drive Name of the sharepoint drive the file sits on. Can be found in the URL of the sharepoint location e.g. for "departmentfortransportuk.sharepoint.com/sites/Rail/RailStats", the drive name is "RailStats". Can also be found using the list_sharepoint_drives() function in this package.
#' @param destination Folder and filename location to download the file to. Defaults to NULL, which saves the file with it's current filename in your current working directory.
#' @export
#' @importFrom Microsoft365R get_sharepoint_site

import_sharepoint <- function(file, site, drive, destination = NULL) {

  site <- Microsoft365R::get_sharepoint_site(
    site_url =
      paste0("https://departmentfortransportuk.sharepoint.com/sites/", site),
    auth_type = "device_code")

  drive <- site$get_drive(drive)

  if(!is.null(destination)){
    if(!dir.exists(file.path(destination))){
      stop("folder ", gsub("(^.*[/]).*", "\\1", file.path(destination)),
           "does not exist in this directory")
    }
  }

  ##If no location, just put file at top location in wd
  if(is.null(destination)){
    destination = gsub("^.*[/]", "", file)
  }

  #Import file from Sharepoint
  drive$download_file(src = file,
                      dest = destination)
  }

#' List the sharepoint drives available in the specified site, useful for finding their names
#' @name list_sharepoint_drives
#' @param site Name of sharepoint site you want to take a file from. Can be found in the URL of the Sharepoint location, e.g. for "departmentfortransportuk.sharepoint.com/sites/Rail", the site name would be Rail
#' @export
#' @importFrom Microsoft365R get_sharepoint_site
list_sharepoint_drives <- function(site) {

  site <- Microsoft365R::get_sharepoint_site(
    site_url =
      paste0("https://departmentfortransportuk.sharepoint.com/sites/", site),
    auth_type = "device_code")

  site$list_drives()
}

#' Export an R object as a CSV or XLSX file to a specified Sharepoint location
#' @name export_sharepoint
#' @param x data object in R
#' @param file Name and location of the file you want to save to sharepoint. Includes the extension and any folders after the drive name
#' @param site Name of sharepoint site you want to save a file to. Can be found in the URL of the Sharepoint location, e.g. for "departmentfortransportuk.sharepoint.com/sites/Rail", the site name would be Rail
#' @param drive Name of the sharepoint drive you want to save the file to Can be found in the URL of the sharepoint location e.g. for "departmentfortransportuk.sharepoint.com/sites/Rail/RailStats", the drive name is "RailStats". Can also be found using the list_sharepoint_drives() function in this package.
#' @export
#' @importFrom Microsoft365R get_sharepoint_site
#' @importFrom openxlsx write.xlsx
#' @importFrom data.table fwrite

export_sharepoint <- function(x, file, site, drive){

  site_loc <- Microsoft365R::get_sharepoint_site(
    site_url =
      paste0("https://departmentfortransportuk.sharepoint.com/sites/", site),
    auth_type = "device_code")

  drive_loc <- site_loc$get_drive(drive)

  ##Check your filename has a usable extension
  if(!grepl("[.](xlsx|csv)$", file)){
    stop("Please make sure your file name includes the file extension, and is either xlsx or csv")
  }

  ##Check your folder exists
  ##Folder without file name
  folder <- gsub("(.*[/]).*$", "\\1", file)
  drive_exist <- try(drive_loc$get_item(folder), silent = TRUE)

  if( "try-error" %in% class(drive_exist) ) {
    stop("Folder location ", folder, " not found")
  }

  if(grepl("[.]xlsx$", file)){

    #Turn your R object into a file
    temp <- tempfile(fileext = ".xlsx")
    openxlsx::write.xlsx(x, temp)

  } else if(grepl("[.]csv$", file)){

    #Turn your R object into a file
    temp <- tempfile(fileext = ".csv")
    data.table::fwrite(x, temp)

  } else{
    stop("Please make sure your file name includes the file extension, and is either xlsx or csv")
  }

  #Save that file on sharepoint
  drive_loc$upload_file(src = temp,
                        dest = file)

}

#' Export an R object as a CSV or XLSX file to a specified Sharepoint location
#' @name export_sharepoint_file
#' @param x Name and location of a local file.
#' @param file Name and location on sharepoint you want the file to be saved to. Includes the extension and any folders after the drive name
#' @param site Name of sharepoint site you want to save a file to. Can be found in the URL of the Sharepoint location, e.g. for "departmentfortransportuk.sharepoint.com/sites/Rail", the site name would be Rail
#' @param drive Name of the sharepoint drive you want to save the file to Can be found in the URL of the sharepoint location e.g. for "departmentfortransportuk.sharepoint.com/sites/Rail/RailStats", the drive name is "RailStats". Can also be found using the list_sharepoint_drives() function in this package.
#' @export
#' @importFrom Microsoft365R get_sharepoint_site

export_sharepoint_file <- function(x, file, site, drive){

  site_loc <- Microsoft365R::get_sharepoint_site(
    site_url =
      paste0("https://departmentfortransportuk.sharepoint.com/sites/", site),
    auth_type = "device_code")

  drive_loc <- site_loc$get_drive(drive)

  ##Check your file exists
  if(!file.exists(x)){
    stop("File ", x, " not found")
  }

  ##Check your folder exists
  ##Folder without file name
  folder <- gsub("(.*[/]).*$", "\\1", file)
  drive_exists <- try(drive_loc$get_item(folder), silent = TRUE)

  if("try-error" %in% class(drive_exists) ) {
    stop("Folder location ", folder, " not found")
  }

  #Save that file on sharepoint
  drive_loc$upload_file(src = x,
                        dest = file)

}

