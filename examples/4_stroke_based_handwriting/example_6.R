# Example 6. This example explores the use of multiple canvas with p5.js.
# Stroke-based handwriting recognition. This app is inspired by:
# https://jackschaedler.github.io/handwriting-recognition/ and
# https://distill.pub/2016/handwriting/
rm(list = ls())
library(jsReact)
library(magrittr)

my_html <- create_html() %>%
  add_js_library("p5") %>%
  add_title("Stroke-based handwriting system") %>%

  add_container(id = "row_1") %>%
    add_item(id = "db", into = "row_1") %>%
    add_item(id = "ctl_1", into = "row_1") %>%
      add_button(into = "ctl_1", text = "Clear", onclick = "clear_everything()") %>%

  add_container(id = "row_2") %>%
    add_item(id = "db_2", into = "row_2") %>%
    add_item(id = "ctl_2", into = "row_2") %>%
      add_text("Smoothing parameter:", into = "ctl_2") %>%
      add_slider(into = "ctl_2", type = "range", id = "smoothing_input",
                 min = "0.0", max = "1.0", step = "0.01", value = "0",
                 oninput = "slider_smooth(value)") %>%

  add_container(id = "row_3") %>%
    add_item(id = "db_3", into = "row_3") %>%
    add_item(id = "ctl_3", into = "row_3") %>%
      add_text("Thinning parameter:", into = "ctl_3") %>%
      add_slider(into = "ctl_3", type = "range", id = "thinning_input",
                 min = "0", max = "40", value = "0",
                 oninput = "slider_thin(value)")


my_html %<>% add_style("
  #ctl_1, #ctl_2, #ctl_3 {
    padding-bottom: 8px;
  }")

my_html %<>%
  add_script_from_file("R.js") %>%
  add_script_from_file("example_6.js")


r_fun <- function(msg) {
  msg
}


preview_app(my_html, r_fun, T)
