#' @title Remove creator names from the metadata of an ods file and add new tags if wanted
#' @param file name of an ods file to edit the metadata
#' @param tags optional tags to add to the file. Defaults to NULL
#' @export
#' @name clean_metadata
#'
#' @import xml2
#' @importFrom magrittr "%>%"

clean_metadata <- function(file, tags = NULL){

  ##Tempfolder
  tempfolder <- tempdir()
  ##Check it's empty
  unlink(list.files(tempfolder, full.names = TRUE), recursive = TRUE)
  ##Unzip your ods
  unzip(file, exdir = tempfolder)

  ##Read in the meta file
  meta <- xml2::read_xml(file.path(tempfolder, "meta.xml"))

  ##Remove creator details
  meta %>%
    xml2::xml_children() %>%
    xml2::xml_child("dc:creator") %>%
    xml2::xml_remove()

  #~Remove initial creator details
  meta %>%
    xml2::xml_children() %>%
    xml2::xml_child("meta:initial-creator") %>%
    xml2::xml_remove()

  ##If there are tags, add the tags
  if(!is.null(tags)){
    for(i in seq_along(tags)){
        meta %>%
          xml2::xml_children() %>%
          xml2::xml_add_child(.value = "meta:keyword",
                              tags[i])
    }
  }

  xml2::write_xml(meta, file.path(tempfolder, "meta.xml"))

  #Zip everything back up nicelt
  zip_tmp_to_path(tempfolder,
                  file)


}
