#' Add a slider with text description (to body)
#' @description This widget consists of two spans and a slider.
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @param text character string; description of the slider.
#' @param text_id character string; id for the span tag which contains the text.
#' @param value character string; the slider default value.
#' @param oninput character string; command to run when slider updates.
#' @param input_default T or F; whether to use the default oninput command (which controls the textbox).
#' @param ... Extra parameter that goes into a tag, e.g. In <div type = "xxx">, 'type = "xxx"' goes to ... .
#' @export
add_slider_with_text <- function(my_html, into = "<body>",
                                 text, text_id, value,
                                 oninput = '', input_default = T, ...) {
  script_1 <- html5_elements(my_html, into, insert = F, tag = "span", text = text)
  value_id <- ifelse(missing(text_id), paste0("slider-value-", text), text_id)
  script_2 <- html5_elements(my_html, into, insert = F, tag = "span", text = value, id = value_id)
  if (input_default) {
    default <- sprintf("document.getElementById(\"%s\").innerHTML = this.value;", value_id)
    oninput <- paste0(default, oninput, ";")
  }
  script_3 <- add_widget("input", type = "range", oninput = oninput, value = value, ...)[1]

  script <- paste0("<div>\n", script_1, script_2, script_3, "\n", "</div>\n")
  my_html %<>% insert_into(script, into)
}


#' Add a counter with text
#' @description This widget consists of two spans and a slider.
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @param text character string; description of the counter.
#' @param counter_id character string; id for the span tag which shows the count.
#' @param value character string; the counter default value.
#' @export
add_counter <- function(my_html, into = "<body>", text, counter_id, value = '') {
  script_1 <- html5_elements(my_html, into, insert = F, tag = "span", text = text)
  script_2 <- html5_elements(my_html, into, insert = F, tag = "span", text = value, id = counter_id)

  script <- paste0("<div>\n", script_1, script_2, "\n", "</div>\n")
  my_html %<>% insert_into(script, into)
}


#' Add a google-style play-pause button
#' @description This widget adds a switch button
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @param ... Other parameters to be passed as tag attributes.
#' @export
add_google_play_pause <- function(my_html, into = "<body>", ...) {
  switch_image <- paste0(
    '<i id="play" class="material-icons">play_circle_outline</i>', '\n',
    '<i id="pause" class="material-icons" style="display:none">pause_circle_outline</i>'
  )
  html5_elements(my_html, into, tag = "button", text = switch_image,
                 style = "outline: none; background: white; border:none;", ...)
}


#' Add a google-style single image button
#' @description This widget adds a button
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @param material_id Material id from google material design, e.g. play_circle_outline.
#' More other options, see https://material.io/icons/.
#' @param ... Other parameters to be passed as tag attributes.
#' @export
add_google_style_button <- function(my_html, into = "<body>", material_id, ...) {
  icon <- sprintf('<i class="material-icons">%s</i>', material_id)
  html5_elements(my_html, into, tag = "button", text = icon,
                 style = "outline: none; background: white; border:none;", ...)
}
