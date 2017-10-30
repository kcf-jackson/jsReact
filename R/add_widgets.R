#' Add slider to body
#' @export
add_button <- function(my_html, into = "<body>", text = "", ...) {
  button_html <- add_widget("button", ...)
  script <- paste0(button_html[1], text, button_html[2])
  my_html %<>% insert_into(script, into)
}


#' Add slider to body
#' @export
add_slider <- function(my_html, into = "<body>", ...) {
  script <- add_widget("input", ...)[1]
  print(script)
  my_html %<>% insert_into(script, into)
}


#' Generic function to produce widgets
#' @keywords internal
add_widget <- function(tag, ...) {
  start_tag <- sprintf("<%s %s>", tag, dots_to_arg(list(...)))
  end_tag <- sprintf("</%s>", tag)
  c(start_tag, end_tag)
}


# Helper function
dots_to_arg <- function(l0) {
  purrr::map2_chr(names(l0), l0, ~sprintf("%s = '%s'", .x, .y)) %>%
    paste0(collapse = ", ")
}
