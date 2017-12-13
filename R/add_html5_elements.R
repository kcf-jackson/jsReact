#' Create builders for html5 elements
#' @description A generic function to produce html 5 elements
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @param insert T or F, if FALSE, return the element instead of inserting into html.
#' @param tag html tag, e.g. div, span, h3.
#' @param text character string; the display text on the button
#' @param close_tag T or F. Should closing tag be included?
#' @param collapse T or F. Whether or not to collapse the script into a single line.
#' @param ... Other parameter passing to tag attributes.
#' @export
html5_elements <- function(my_html, into, insert = T, tag, text, close_tag = T,
                           collapse = T, ...) {
  if (missing(into)) into <- "<body>"
  script <- add_widget(tag, text, ...)
  if (!close_tag) {
    script <- script[1]
  } else if (collapse) {
    script <- paste(script, collapse = "")
  }
  if (insert) return(insert_into(my_html, script, into))
  script
}


#' Generic function to produce widgets
#' @keywords internal
add_widget <- function(tag, text = '', ...) {
  start_tag <- sprintf("<%s%s>", tag, dots_to_arg(list(...)))
  end_tag <- sprintf("%s</%s>", text, tag)
  c(start_tag, end_tag)
}


#' Convert dots into html tag attributes
#' @keywords internal
dots_to_arg <- function(l0, collapse = " ") {
  purrr::map2_chr(names(l0), l0, ~sprintf(" %s='%s'", .x, .y)) %>%
    paste0(collapse = collapse)
}
