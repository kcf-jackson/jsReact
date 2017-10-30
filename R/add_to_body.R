#' Add a section (div element) to body
#' @export
add_div <- function(my_html, class, id, align, into = "<body>") {
  str0 <- "<div"
  if (!missing(class))
    str0 %<>% paste0(sprintf(" class='%s'", class))
  if (!missing(id))
    str0 %<>% paste0(sprintf(" id='%s'", id))
  if (!missing(align))
    str0 %<>% paste0(sprintf(" align='%s'", align))
  str0 %<>% paste0(">")
  str0 %<>% c("</div>")
  insert_into(my_html, str0, into)
}


#' Add a container (div element) to body
#' @export
add_container <- curry::partial(add_div, list(class = "container"))


#' Add a item (div element) to body
#' @export
add_item <- curry::partial(add_div, list(class = "item"))


#' Add a section (div element) to body
#' @export
add_column <- curry::partial(add_div, list(class = "column"))


#' Add a section (div element) to body
#' @export
add_row <- curry::partial(add_div, list(class = "row"))


#' Add Javascript to body
#' @export
add_script <- function(my_html, script) {
  script <- paste0("<script>\n", script, "\n</script>\n")
  insert_into(my_html, script, "<body>")
}


#' Add Javascript from file to body
#' @export
add_script_from_file <- function(my_html, file) {
  add_script(my_html, html_to_string(file))
}


#' Add title to body
#' @export
add_title <- function(my_html, title, size = 3, into = "<body>") {
  my_title <- sprintf("<h%s>%s</h%s>", size, title, size)
  insert_into(my_html, my_title, into)
}


#' Add text
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param text character string; text to be added.
#' @export
add_text <- function(my_html, text, into = "<body>") {
  insert_into(my_html, text, into)
}
