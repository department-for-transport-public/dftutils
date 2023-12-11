#' @title Remove font colours from ODS files to ensure they only use automatic colours (exception for hyperlinks)
#' @param file name of an ods file to remove font colours from
#' @export
#' @name remove_colours
#'
#' @import xml2
#' @importFrom magrittr "%>%"

remove_colours <- function(file){

  ##Create a Tempfolder
  tempfolder <- tempdir()
  ##Check it's empty
  unlink(list.files(tempfolder, full.names = TRUE), recursive = TRUE)

  ##Unzip your ods
  unzip(file, exdir = tempfolder)

  ##Read in the content file
  content <- xml2::read_xml(file.path(tempfolder, "content.xml"))

  ##Set the namespaces
  ns <- xml2::xml_ns(content)

  ##Remove all font colours from the font styles
  content %>%
    ##Exclude links; this finds all styles except those with "link colour"
    ##Why isn't xml case sensitive? Unclear, but thanks for making it harder
    xml2::xml_find_all(".//style:text-properties[not(@fo:color='#0563c1' or @fo:color='#0563C1')]", ns = ns) %>%
    xml2::xml_set_attr("fo:color", value = NULL,  ns = ns)

  ##If length of attributes is now zero, replace with default, which is to use default colour
  content %>%
    xml2::xml_find_all(".//style:text-properties[not(@*)]", ns = ns) %>%
    xml2::xml_set_attr(attr = "style:use-window-font-color", value = "true")

  #Write the modified contents back to the temp folder
  xml2::write_xml(content, file.path(tempfolder, "content.xml"))

  ##Zip the temp folder back up
  zip_tmp_to_path(tempfolder, file)
}



