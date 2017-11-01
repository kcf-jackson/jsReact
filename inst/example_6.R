# Stroke-based handwriting recognition
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
      add_slider(into = "ctl_2", type = "range", id = "smoothing_input",
                 min = "0.0", max = "1.0", step = "0.01", value = "0",
                 oninput = "slider_smooth(value)") %>%

  add_container(id = "row_3") %>%
    add_item(id = "db_3", into = "row_3") %>%
    add_item(id = "ctl_3", into = "row_3") %>%
      add_slider(into = "ctl_3", type = "range", id = "thinning_input",
                 min = "0", max = "40", value = "0",
                 oninput = "slider_thin(value)")


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
    }
    .container#column_3 {
      display: flex;
      flex-direction: column;
      padding-top: 1.1em;
    }
    ")

my_html %<>%
  # add_script_from_file("inst/p5.js") %>%
  add_script_from_file("inst/R.js") %>%
  add_script_from_file("inst/example_6.js")
write_html_to_file(my_html, file = "inst/sample.html")


r_fun <- function(msg) {
  msg
}


my_app <- create_app("inst/sample.html", r_fun)
start_app(my_app)
