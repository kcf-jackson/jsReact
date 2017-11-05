# This example explores preliminary setup using R data and linked plots.
rm(list = ls())
library(jsReact)
library(magrittr)
library(glmnet)

my_html <- create_html() %>%
  add_js_library(c("p5", "plotly")) %>%
  add_title("Digits recognition with GLM") %>%
  add_container(id = "row_1") %>%
    add_container(id = "column_1", into = "row_1") %>%
      add_item(id = "text_item", align = 'left', into = "column_1") %>%
      add_text("Drag to draw. Drag with key pressed to erase.", into = "text_item") %>%
    add_container(id = "column_2", into = "row_1") %>%
      add_item(id = "result_table", into = "column_2") %>%
      add_item(id = "digit_gain", into = "column_2") %>%
      add_button(into = "column_2", text = "Clear", onclick = "clear_everything()") %>%
  add_container(id = "row_2") %>%
    add_container(id = "column_21", into = "row_2") %>%
    add_container(id = "column_22", into = "row_2") %>%
    add_container(id = "column_23", into = "row_2") %>%
    add_container(id = "column_24", into = "row_2") %>%
    add_container(id = "column_25", into = "row_2") %>%
  add_container(id = "row_3") %>%
    add_container(id = "column_31", into = "row_3") %>%
    add_container(id = "column_32", into = "row_3") %>%
    add_container(id = "column_33", into = "row_3") %>%
    add_container(id = "column_34", into = "row_3") %>%
    add_container(id = "column_35", into = "row_3")

my_html %<>% add_style(
  ".container#row_1, .container#row_2, .container#row_3 {
  display: flex;
  flex-direction: row;
  justify-content: center;
  padding-bottom: 1.1em;
  }
  .container#column_1, .container#column_2, .container#column_3{
  display: flex;
  flex-direction: column;
  padding-left: 1.1em;
  padding-right: 1.1em;
  }
  .container#column_21, .container#column_22, .container#column_23,
  .container#column_24, .container#column_25, .container#column_31,
  .container#column_32, .container#column_33, .container#column_34,
  .container#column_35 {
    padding-left: 1em;
    padding-right: 1em;
  }
  button {
    width: 9em;
    padding-left: 1.1em;
    padding-right: 1.1em;
  }
  th, td {
  padding: 8px;
  text-align: center;
  border-bottom: 1px solid #ddd;
  }
  table {
  border-collapse: collapse;
  border: 1px solid black;
  line-height: 13px;
  }
  #result_table {
  padding-top: 1.1em;
  padding-bottom: 8px;
  }")

my_html %<>%
  add_script_from_file("R.js") %>%
  add_script_from_file("example_7_helper.js") %>%
  add_script_from_file("example_7_setup.js") %>%
  add_script_from_file("example_7_canvas.js") %>%
  add_script_from_file("example_7_init.js")
write_html_to_file(my_html, file = "sample.html")


# Use this if you want to see your own handwriting in R plot.
show_digit <- function(arr784, col=gray(12:1/12), ...) {
  image(matrix(arr784, nrow=28)[,28:1], col=col, ...)
}
# This function rearranges the pixel to align with the training data
reshuffle <- function(vec0) {
  vec0 <- as.numeric(vec0)
  as.numeric(matrix(vec0, 28, 28, byrow = T))
}
# Get regression coefficients for each digit
digit_coefficients <- function(model_obj) {
  coefficients(model_obj) %>% as.list() %>%
    purrr::map(~reshuffle(as.numeric(tail(.x, -1))))
}


load("fitted_glmnet", verbose = T)
r_fun <- function(msg) {
  if ("init" %in% names(msg)) {
    return(list(init = "true", data = digit_coefficients(cv)))
  } else {
    msg <- reshuffle(msg) * 255
    # show_digit(msg)
    pred <- predict(cv, t(data.frame(msg)), type = 'response')
    #list(class = 0:9, pred = as.numeric(pred))  #use this if you want to process on the JS side

    return(list(
      init = "false",
      'table' = print(
          xtable::xtable(t(data.frame(
            class = as.character(0:9),
            pred = round(as.numeric(pred), 3)
          ))),
          type = 'html', print.results = F, include.colnames = F
      )
    ))
  }
}

my_app <- create_app("sample.html", r_fun)
start_app(my_app)
