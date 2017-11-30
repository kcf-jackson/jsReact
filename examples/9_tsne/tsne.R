rm(list = ls())
library(magrittr)
library(jsReact)

my_html <- create_html() %>%
  add_script_from_link("https://rawgit.com/karpathy/tsnejs/master/tsne.js") %>%
  add_js_library("plotly") %>%
  add_style_from_link("https://fonts.googleapis.com/icon?family=Material+Icons") %>%
  add_title("Interactive t-SNE in R") %>%
  add_column(id = "column_left") %>%
    add_row(id = "row_1", into = "column_left") %>%
    add_google_style_button(
      material_id = "fast_rewind", into = "row_1", onclick = "fast_rewind()"
    ) %>%
    add_google_play_pause(id = "play-pause", class = "playing",
                          into = "row_1", onclick = "switch_class(); start_pause();") %>%
    add_google_style_button(material_id = "replay", into = "row_1", onclick = "restart()") %>%
    add_google_style_button(
      material_id = "fast_forward", into = "row_1", onclick = "fast_forward()"
    ) %>%
    add_row(id = "row_2", into = "column_left") %>%
      add_counter(text = "Step ", value = "0", counter_id = "my_counter", into = "row_2") %>%
    add_row(id = "row_3", into = "column_left") %>%
      add_slider_with_text(
        text = "Perplexity ", min = "2", max = "100", step = "1", value = "10",
        into = "row_3", onchange = "update_perp(this.value)",
        style = "display:block; margin-top: 8pt;"
      ) %>%
    add_row(id = "row_4", into = "column_left") %>%
      add_slider_with_text(
        text = "Epsilon ", min = "1", max = "20", step = "1", value = "5",
        into = "row_4", onchange = "update_eps(this.value)",
        style = "display:block; margin-top: 8pt; margin-bottom: 8pt;"
      ) %>%
  add_column(id = "column_right") %>%
    add_div(id = "plotly_plot", into = "column_right") %>%
  add_style("
      .column { float:left; }
      .column#column_left {
        padding-top: 30px; padding-left:20px;padding-right:30px;
      }
      .row{ padding-top: 5px; padding-left: 5px; padding-bottom: 8px;}
      h3{ margin-bottom: 10px }
            ")
my_html %<>%
  add_script_from_file("tsne.js")


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


# write_html_to_file(my_html, "tsne.html")
preview_app(my_html, my_r_fun, T)
