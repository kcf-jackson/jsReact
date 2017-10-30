rm(list = ls())
library(jsReact)
library(magrittr)
library(glmnet)

my_html <- create_html() %>%
  add_js_library("p5") %>%
  # add_style("<style> .column#column_2 { max-width: 50%; } </style>") %>%
  add_row(id = "row_1") %>%
  add_column(id = "column_1", into = "row_1") %>%
  add_column(id = "column_2", align = 'center', into = "column_1") %>%
  add_text("<b>Digits recognition</b><br>", into = "column_2") %>%
  add_text("Drag to draw. Drag with key pressed to erase.", into = "column_2") %>%
  add_column(id = "column_2", into = "row_1")
my_html %<>%
  add_script_from_file("inst/R.js") %>%
  add_script_from_file("inst/example_5.js")
write_html_to_file(my_html, file = "inst/sample.html")


load("inst/fitted_glmnet", verbose = T)
r_fun <- function(msg) {
  msg <- matrix(as.numeric(msg), 28, 28, byrow = F)
  new_data <- t(data.frame(as.numeric(msg) * 255))
  print(new_data)
  pred <- predict(cv, new_data, type = 'response')
  print(pred)
  list(class = 0:9, pred = as.numeric(pred))
}


my_app <- create_app("inst/sample.html", r_fun)
start_app(my_app)
