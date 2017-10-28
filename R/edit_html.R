# Functions to add things to header.

#' Add js libraries src files to html header
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param jslibs A vector of strings; JS libraries to use. Currently support
#' 'plotly', 'p5', 'd3', 'vega'.
#' @export
add_js_library <- function(my_html, js_libs) {
  src <- js_src()
  for (i in js_libs) {
    if (i %in% names(src)) {
      my_html %<>% insert_before(src[[i]], "</head>", .)
    }
  }
  my_html
}


#' Add title to html header
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param title character string; title.
#' @export
add_header_title <- function(my_html, title) {
  my_title <- sprintf("<title> %s <title>", title)
  insert_before(my_title, "</head>", my_html)
}


#' Add css style to html header
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param file character string; path to the css file.
#' @export
add_style_from_file <- function(my_html, file) {
  my_css <- JS_(readLines(file))
  insert_before(my_css, "</head>", my_html)
}


# Functions to add things to body.

#' Add title to body
#' @export
add_title <- function(my_html, title, size = 3) {
  my_title <- sprintf("<h%s>%s<h%s>", size, title, size)
  insert_before(my_title, "</body>", my_html)
}


#' #' Add a section (div element) to body
#' #' @export
#' add_div <- function(file, tag, size = 3) {
#'
#' }
#'
#'
#' #' Add a form to body
#' #' @export
#' add_form <- function(file, tag) {
#'
#' }
#'
#'
#' #' Add a slider to body
#' #' @export
#' add_slider <- function(file, tag) {
#'
#' }
#'
#'
#' #' Add anything by id
#' #' @export
#' add_anything_to_id <- function(thing, id) {
#'
#' }
