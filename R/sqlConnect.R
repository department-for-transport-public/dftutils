#' Connect to a SQL database on the Cloud R computing environment
#
#' @param server string. Name of the server you would like to connect to.
#' @param database string. Name of the database within the server you would like
#' to connect to
#'
#' @importFrom odbc odbc
#' @importFrom DBI dbConnect dbCanConnect
#' @name sqlConnect
#' @export

sqlConnect <- function(server, database) {

  ##Checks if it's possible to connect to server specified
  check <- DBI::dbCanConnect(odbc::odbc(),
                             Driver = "{ODBC Driver 17 for SQL Server}",
                             Server = server,
                             Trusted_Connection = "yes")

  if(!check){
    stop("Connection to server could not be established:",
         attr(check, "reason"))
  }

  ##Establish connection to server
  DBI::dbConnect(odbc::odbc(),
                 Driver = "{ODBC Driver 17 for SQL Server}",
                 Server = server,
                 Trusted_Connection = "yes",
                 Database = database)

}
