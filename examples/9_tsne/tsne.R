rm(list = ls())
library(magrittr)
library(jsReact)


my_html <- create_html() %>%
  add_script_from_link("https://rawgit.com/karpathy/tsnejs/master/tsne.js") %>%
  add_js_library("plotly") %>%
  add_title("Interactive t-SNE in R") %>%
  add_column(id = "column_left") %>%
    add_div(id = "plotly_plot", into = "column_left") %>%
  add_column(id = "column_right") %>%
    add_row(id = "row_1") %>%
      add_button(text = "Start / Pause", into = "row_1") %>%
      add_button(text = "Restart", into = "row_1") %>%
    add_row(id = "row_2") %>%
      add_slider(into = "row_2") %>%
      add_slider(into = "row_2") %>%
      add_slider(into = "row_2") %>%
  add_style(".column { float:left; }")

my_html %<>%
  add_script_from_file("examples/9_tsne/tsne.js")


sample_data <- function(n, ...) {
  sim_cov <- function(p = 3, ...) {
    A <- matrix(rnorm(p ^ 2, ...) * 2 - 1, ncol = p)
    t(A) %*% A
  }
  n %>% seq() %>%
    purrr::map(~matrix(sim_cov(3, ...), nrow = 1)) %>%
    do.call(rbind, .)
}
my_r_fun <- function(msg) {
  # Pass whatever data you have to JS!
  n <- 100
  random_data <- rbind(
    sample_data(n), sample_data(n, mean = 10, sd = 4)
  )
  list(r_dist_matrix = as.matrix(dist(random_data)),
       color = c(rep(0, n), rep(1, n)))
}


preview_app(my_html, my_r_fun, T)
