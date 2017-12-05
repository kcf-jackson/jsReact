# #' Add bootstrap style files to header
# #' @param my_html html in a vector of strings; output from 'create_html'.
# #' @export
# add_bootstrap_style <- function(my_html) {
#   src <- js_src()
#   for (i in js_libs) {
#     if (i %in% names(src)) {
#       my_html %<>% insert_into(src[[i]], "<head>")
#     }
#   }
#   my_html
# }


#' Add js libraries src files to html header
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param js_libs A vector of strings; JS libraries to use. Currently support
#' 'plotly', 'p5', 'd3', 'vega'.
#' @export
add_js_library <- function(my_html, js_libs) {
  src <- js_src()
  for (i in js_libs) {
    if (i %in% names(src)) {
      my_html %<>% insert_into(src[[i]], "<head>")
    } else if (tolower(i) == "r") {
      my_file <- system.file("R.js", package = "jsReact")
      my_html %<>% add_script_from_file(my_file)
    }
  }
  my_html
}


#' Generic function to add a pair of enclosing "tags" to "script", then insert into "into" of "my_html"
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param script character string; script to add.
#' @param tag character string; html tags, e.g. div, span, script, style, h3.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @export
add_tag_into <- function(my_html, script, tag, into) {
  script_with_tags <- sprintf("<%s> %s </%s>", tag, script, tag)
  insert_into(my_html, script_with_tags, into)
}


#' Add title to html header
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param script character string; title.
#' @export
add_header_title <- curry::partial(add_tag_into, list(tag = "title", into = "<head>"))


#' Add css style to html header
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param script character string; css style.
#' @export
add_style <- curry::partial(add_tag_into, list(tag = "style", into = "<head>"))


#' Add css style to html header
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param file character string; path to the css file.
#' @export
add_style_from_file <- function(my_html, file) {
  my_css <- JS_(readLines(file))
  add_style(my_html, my_css)
}


#' Add css style to html header
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param link character string; external link to the css file.
#' @export
add_style_from_link <- function(my_html, link) {
  my_css <- sprintf("<link rel='stylesheet' href=%s>", link)
  insert_into(my_html, my_css, "<head>")
}


#' Add google material icon
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @export
add_google_style <- function(my_html) {
  link <- "https://fonts.googleapis.com/icon?family=Material+Icons"
  my_css <- sprintf("<link rel='stylesheet' href=%s>", link)
  insert_into(my_html, my_css, "<head>")
}
