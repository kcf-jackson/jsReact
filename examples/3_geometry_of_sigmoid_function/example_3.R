# Example 3. Explore R-JS interaction with p5.js and plotly.js.
rm(list = ls())
library(jsReact)
library(magrittr)

my_html <- create_html() %>%
  add_js_library(c("plotly", "p5")) %>%
    add_column(id = "column_1") %>%
      add_title("Parameter domain", into = "column_1") %>%
      add_div(id = "p5_canvas", into = "column_1") %>%
    add_column(id = "column_2") %>%
      add_div(id = "plotly_plot", into = "column_2") %>%
  add_style(
    ".column { float:left; }
    h3 { margin-top: 2cm; }"
  ) %>%
  add_script_from_file("example_3.js")

my_r_fun <- function(msg) {
  beta_1 <- msg$x * 10
  beta_2 <- msg$y
  x <- seq(-100, 100, length.out = 100)
  y <- boot::inv.logit(beta_1 + beta_2 * x)
  list(x = x, y = y)
}

preview_app(my_html, my_r_fun, T)
