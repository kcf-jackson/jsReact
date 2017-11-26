# Example 2. Explore R-JS interaction with plotly.js.
rm(list = ls())
library(jsReact)
library(magrittr)
my_html <- create_html() %>%
  add_js_library("plotly") %>%
  add_title("Send message") %>%
  add_slider(min = "0", max = "100", oninput = "show_value(value)") %>%
  add_title("Receive message") %>%
  add_div(id = "output") %>%
  add_div(id = "plotly_plot")
my_html %<>% add_script("
  function show_value(value) {
    ws.send(value);
  }
  ws.onmessage = function(msg) {
    document.getElementById('output').innerHTML = msg.data;
    var data0 = JSON.parse(msg.data);
    var trace1 = {x: data0['x'], y: data0['y'], mode: 'markers', type: 'scatter'};
    var layout = {xaxis:{range: [-4, 4]}, yaxis: {range: [-20, 120]},
                  margin: {l:35, r:20, b:35, t:20}, width:550, height:400};
    Plotly.newPlot('plotly_plot', [trace1], layout);
  }
")
my_r_fun <- function(msg) {
  print(msg)
  list(x = rnorm(1), y = as.numeric(msg))
}
preview_app(my_html, my_r_fun, T)
