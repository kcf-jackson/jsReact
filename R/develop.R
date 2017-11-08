#' Helper function to aid developing and testing codes
#' @param file character string; the filepath.
#' @param code character string; the code to be run when a change is made to file.
#' @param time numeric; monitoring change of file every "time" seconds.
#' @param catch_error boolean; whether to print out error.
#' @export
developing <- function(file, code, time = 1, catch_error = T) {
  if (!file.exists(file)) {
    stop("File doesn't exist.")
  }
  ongoing_md5 <- ""
  while (TRUE) {
    new_md5 <- tools::md5sum(file)
    if (new_md5 != ongoing_md5) {
      ongoing_md5 <- new_md5
      if (catch_error) {
        tryCatch(
          eval(parse(text = code)),
          warning = function(w) { print(w) },
          error = function(e) { print(e) }
        )
      } else {
        eval(parse(text = code))
      }
    }
    Sys.sleep(time)
  }
}


#' Helper function to aid developing and testing html file
#' @param file character string; the filepath.
#' @param time numeric; monitoring change of file every "time" seconds.
#' @export
developing_html <- function(file, time = 1) {
  code <- sprintf("getOption('viewer')('%s')", file)
  developing(file, code, time)
}


#' Helper function to aid developing and testing R codes
#' @param file character string; the filepath.
#' @param time numeric; monitoring change of file every "time" seconds.
#' @param catch_error boolean; whether to print out error.
#' @export
developing_r <- function(file, time = 1, catch_error = T) {
  code <- sprintf("source('%s')", file)
  developing(file, code, time, catch_error)
}
