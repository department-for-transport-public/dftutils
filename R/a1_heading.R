#' @title Format A1 cell in every sheet to Heading style for accessibility purposes
#' @param file name of an ods file to add heading format to
#' @export
#' @name a1_heading
#'
#' @import xml2
#' @importFrom magrittr "%>%"

a1_heading <- function(file){
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

  ##Find the style name of the first cell in each sheet
  styles <- content %>%
    xml2::xml_find_all(".//table:table") %>%
    xml2::xml_child(".//table:table-cell", ns = ns) %>%
    xml2::xml_attr("style-name") %>%
    unique()

  ##Make it into a big long string
  styles <- paste(paste0("@style:name='", styles, "'"), collapse = " or ")

  ##Find those styles
  content %>%
    xml2::xml_find_all(paste0(".//style:style[", styles, "]"), ns = ns) %>%
    ##Set the style parent style as Heading1
    xml2::xml_set_attr("style:parent-style-name", value = "Heading",  ns = ns)

  xml2::write_xml(content, file.path(tempfolder, "content.xml"))

  dftutils:::zip_tmp_to_path(tempfolder, file)
}
