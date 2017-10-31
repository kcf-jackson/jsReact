# Stroke-based handwriting recognition
rm(list = ls())
library(jsReact)
library(magrittr)

my_html <- create_html() %>%
  add_js_library("p5") %>%
  add_title("Stroke-based handwriting system") %>%
  add_container(id = "row_1") %>%
    add_container(id = "column_1") %>%
      add_item(id = "drawing_box", into = "column_1") %>%
    add_container(id = "column_2") %>%
      add_item(id = "text_box", into = "column_2")

my_html %<>% add_style(
  ".container#row_1 {
      display: flex;
      flex-direction: row
    }
    .container#column_1 {
      display: flex;
      flex-direction: column;
    }
    .container#column_2 {
      display: flex;
      flex-direction: column;
      padding-top: 1.1em;
      padding-left: 1.1em;
    }
    ")

my_html %<>%
  add_script_from_file("inst/R.js") %>%
  add_script_from_file("inst/example_6.js")
write_html_to_file(my_html, file = "inst/sample.html")


r_fun <- function(msg) {
  msg
}


my_app <- create_app("inst/sample.html", r_fun)
start_app(my_app)
