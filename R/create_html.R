#' Create a basic html file
#' @export
create_html <- function() {
  data.frame(
    xml = c("<!DOCTYPE html>", "<html>", "<head>",
            "</head>", "<body>", "</body>", "</html>\n"),
    levels = c(0, 1, 2, 2, 2, 2, 1),
    stringsAsFactors = FALSE
  )
}


#' Convert html to string
#' @param str0 A vector of strings; output from 'create_html'.
#' @param file Character string; the filepath.
#' @export
write_html_to_file <- function(my_html, file) {
  cat(JS_(my_html$xml), file = file)
  print(paste0("File ", file, " has been created."))
}
