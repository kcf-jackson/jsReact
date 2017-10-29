#=============== Functions to add things to header ================
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
#' @param str0 character string; css style.
#' @export
add_style <- function(my_html, str0) {
  insert_before(str0, "</head>", my_html)
}


#' Add css style to html header
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param file character string; path to the css file.
#' @export
add_style_from_file <- function(my_html, file) {
  my_css <- JS_(readLines(file))
  insert_before(my_css, "</head>", my_html)
}


#=============== Functions to add things to body ===============
#' Add title to body
#' @export
add_title <- function(my_html, title, size = 3,
                      after, before) {
  my_title <- sprintf("<h%s>%s</h%s>", size, title, size)
  insert_script(my_title, after, before, my_html)
}


#' Add a section (div element) to body
#' @export
add_div <- function(my_html, class, id, align, content,
                    after, before, insert = T) {
  str0 <- "<div"
  if (!missing(class))
    str0 %<>% paste0(sprintf(" class='%s'", class))
  if (!missing(id))
    str0 %<>% paste0(sprintf(" id='%s'", id))
  if (!missing(align))
    str0 %<>% paste0(sprintf(" align='%s'", align))
  str0 %<>% paste0(">")
  if (!missing(content))
    str0 %<>% c(content)
  str0 %<>% c("</div>")
  if (!insert) return(str0)
  insert_script(str0, after, before, my_html)
}


#' Add a section (div element) to body
#' @export
add_column <- curry::partial(add_div, list(class = "column"))


#' Add a section (div element) to body
#' @export
add_row <- curry::partial(add_div, list(class = "row"))


#' Add Javascript to body
#' @export
add_script <- function(my_html, script) {
  insert_before(script, "</body>", my_html)
}


#' Add Javascript from file to body
#' @export
add_script_from_file <- function(my_html, file) {
  add_script(my_html, html_to_string(file))
}


#' Add slider to body
#' @note This function is created using the factory function.
#' @export
add_slider <- function(my_html, type, id, min, max, value, oninput,
                       before, after) {
  str0 <- "<input"
  if (!missing(type)) {
    str0 %<>% paste0(sprintf(" type='%s'", type))
  }
  if (!missing(id)) {
    str0 %<>% paste0(sprintf(" id='%s'", id))
  }
  if (!missing(min)) {
    str0 %<>% paste0(sprintf(" min='%s'", min))
  }
  if (!missing(max)) {
    str0 %<>% paste0(sprintf(" max='%s'", max))
  }
  if (!missing(value)) {
    str0 %<>% paste0(sprintf(" value='%s'", value))
  }
  if (!missing(oninput)) {
    str0 %<>% paste0(sprintf(" oninput='%s'", oninput))
  }
  str0 %<>% paste0(">")
  insert_script(str0, after, before, my_html)
}


#' #' Add anything by id
#' #' @export
#' add_anything_to_id <- function(thing, id) {
#'
#' }


#' #' Add a form to body
#' #' @export
#' add_form <- function(file, tag) {
#'
#' }
