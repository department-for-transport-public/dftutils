#' Update Renv Lockfile
#'
#' This function checks the versions of packages in an `renv` lockfile against a list of known packages which are incompatible with the upgraded version of R.
#' If any problem packages are found, they are replaced with appropriate versions in your lock file.
#'
#' @param lockfile_path Character. The path to the `renv` lockfile. Defaults to `"renv.lock"`, the lockfile in your current project..
#'
#' @return A message indicating which problem packages were identified, and their updated versions
#' @export
#'
#' @importFrom utils packageVersion read.csv
#' @importFrom renv lockfile_read
#' @importFrom purrr map
#'
#' @examples
#' \dontrun{
#' update_renv("path/to/your/renv.lock")
#' }

update_renv <- function(lockfile_path = "renv.lock"){

  ##Check we've got the right version of renv for starters
  if(as.numeric(gsub("[.]", "", utils::packageVersion("renv"))) < 107){
    stop("Please make sure you have the latest version of renv installed (1.0.7 or higher)")
  }

  ##Get our problem libraries
  problem_libs <- read.csv(system.file("data/problem_packages.csv", package = "dftutils"))

  ##Check what versions are in renv
  libs_versions <- renv::lockfile_read(lockfile_path)$Packages

  ##Keep just the ones we know cause issues
  libs_versions <- libs_versions[names(libs_versions) %in% problem_libs$package]

  if(length(libs_versions) == 0){
    message("No problem packages identified in your renv lockfile")
  } else{

    ##Loop over to check which ones are dodgy, and replace them
    purrr::map(.x = libs_versions,
               .f = check_package_v,
               problem_libs = problem_libs,
               lockfile_path = lockfile_path)

  }

}

##Find and compare target version with current version
check_package_v <- function(package_deets, problem_libs, lockfile_path){
  target_version <-
    problem_libs[problem_libs$package == package_deets$Package,]

  if (as.numeric(gsub("[[:punct:]]", "", package_deets$Version)) <
      as.numeric(gsub("[[:punct:]]", "", target_version$version))) {

    ##Record in the lockfile if different
    renv::record(
      records = paste(target_version$package, target_version$version, sep = "@"),
      lockfile = lockfile_path
    )
    #Message for success
    message(target_version$package,
            " version updated to ",
            target_version$version)
  } else{
    ##Message for fail
    message(target_version$package, " already at correct version")
  }
}
