# This example explores preliminary setup using R data and linked plots.
rm(list = ls())
library(jsReact)
library(magrittr)
library(glmnet)

my_html <- create_html() %>%
  add_js_library("p5") %>%
  add_title("Digits recognition with GLM") %>%
  add_container(id = "row_1") %>%
  add_container(id = "column_1", into = "row_1") %>%
  add_item(id = "text_item", align = 'left', into = "column_1") %>%
  add_text("Drag to draw. Drag with key pressed to erase.", into = "text_item") %>%
  add_container(id = "column_2", into = "row_1") %>%
  add_item(id = "result_table", into = "column_2") %>%
  add_button(into = "column_2", text = "Clear", onclick = "clear_everything()")

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
  th, td {
  padding: 8px;
  text-align: center;
  border-bottom: 1px solid #ddd;
  }
  table {
  border-collapse: collapse;
  border: 1px solid black
  }
  #result_table {
  padding-bottom: 8px;
  }")

my_html %<>%
  add_script_from_file("inst/R.js") %>%
  add_script_from_file("inst/example_7_setup.js") %>%
  add_script_from_file("inst/example_7_canvas.js") %>%
  add_script_from_file("inst/example_7_init.js")
write_html_to_file(my_html, file = "inst/sample.html")


# Use this if you want to see your own handwriting in R plot.
show_digit <- function(arr784, col=gray(12:1/12), ...) {
  image(matrix(arr784, nrow=28)[,28:1], col=col, ...)
}
# This function rearranges the pixel to align with the training data
reshuffle <- function(vec0) {
  vec0 <- as.numeric(vec0)
  as.numeric(matrix(vec0, 28, 28, byrow = T))
}

load("inst/fitted_glmnet", verbose = T)
r_fun <- function(msg) {
  msg <- reshuffle(msg) * 255
  # show_digit(msg)
  pred <- predict(cv, t(data.frame(msg)), type = 'response')
  #list(class = 0:9, pred = as.numeric(pred))  #use this if you want to process on the JS side
  list('table' = print(
    xtable::xtable(data.frame(class = 0:9, pred = as.numeric(pred))),
    type = 'html', print.results = F, include.rownames = F
  ))
}


my_app <- create_app("inst/sample.html", r_fun)
start_app(my_app)
