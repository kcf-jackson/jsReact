#' Add slider to body
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @param text character string; the display text on the button
#' @param ... Extra parameter that goes into a tag, e.g. In <div type = "xxx">, 'type = "xxx"' goes to ... .
#' @export
add_button <- function(my_html, into = "<body>", text = "", ...) {
  button_html <- add_widget("button", ...)
  script <- paste0(button_html[1], text, button_html[2])
  my_html %<>% insert_into(script, into)
}
# add_button <- curry::partial(
#   html5_elements,
#   list(tag = "button", close_tag = T)
# )


#' Add slider to body
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @param ... Extra parameter that goes into a tag, e.g. In <div type = "xxx">, 'type = "xxx"' goes to ... .
#' @export
add_slider <- function(my_html, into = "<body>", ...) {
  script <- add_widget("input", type = "range", ...)[1]
  my_html %<>% insert_into(script, into)
}
# add_slider <- curry::partial(
#   html5_elements,
#   list(tag = "input", text = '', type = "range", close_tag = F)
# )
