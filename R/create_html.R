#' Create a basic html file
#' @export
create_html <- function() {
  c("<!DOCTYPE html>", "<html>", "<head>",
    "</head>", "<body>", "</body>", "</html>\n")
}


#' Convert html to string
#' @param str0 A vector of strings; output from 'create_html'.
#' @param file Character string; the filepath.
#' @export
write_html_to_file <- function(my_html, file) {
  cat(JS_(my_html), file = file)
  print(paste0("File ", file, " has been created."))
}
