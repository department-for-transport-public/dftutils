#' @importFrom zip zip

##Turn an unzipped ods back into an ODS file

zip_tmp_to_path <- function(temp_ods_dir, path) {

  temp_ods <- file.path(temp_ods_dir, basename(path))
  zip::zip(zipfile = temp_ods, include_directories = FALSE, recurse = TRUE,
           files = list.files(temp_ods_dir), mode = "cherry-pick",
           root = temp_ods_dir)
  file.copy(temp_ods, path, overwrite = TRUE)
  return(path)
}
