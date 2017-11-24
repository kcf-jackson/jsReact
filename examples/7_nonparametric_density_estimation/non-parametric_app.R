rm(list = ls())
library(magrittr)
library(jsReact)

source("non-parametric_example.R")

my_html <- create_html() %>%
  add_js_library("plotly") %>%
  add_title("An illustration of non-parametric density estimation") %>%
  add_button(text = "add 1 data points", onclick = "simulate_data(1)") %>%
  add_button(text = "add 10 data points", onclick = "simulate_data(10)") %>%
  add_button(text = "add 100 data points", onclick = "simulate_data(100)") %>%
  add_button(text = "add 1000 data points", onclick = "simulate_data(1000)") %>%
  add_div(id = "plotly_plot") %>%
  add_script(
"
function simulate_data(n) {
  ws.send(JSON.stringify({num_sim: n}))
}
ws.onmessage = function(msg) {
  var data0 = JSON.parse(msg.data);
  var trace1 = {x: data0.true_density.x, y: data0.true_density.y, name: 'true'};
  var trace2 = {x: data0.esti_density.x, y: data0.esti_density.y, name: 'estimated'};
  Plotly.newPlot('plotly_plot', [trace1, trace2])
}
")


# Simluate from DGP
data0 <- simple_DGP(10000)
data1 <- c()
r_fun <- function(msg) {
  # Estimate density
  data1 <<- c(data1, simple_DGP(msg$num_sim))
  est_density <- gaussian_approx(data1)
  true_den <- density(data0)
  list(true_density = list(x = true_den$x, y = true_den$y),
       esti_density = list(x = true_den$x, y = est_density(true_den$x)))
}


preview_app(my_html, r_fun, T)
