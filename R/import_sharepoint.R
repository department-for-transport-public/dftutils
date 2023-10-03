#' Import a file from a specified Sharepoint location
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

  drive <- site$list_drives()
}
