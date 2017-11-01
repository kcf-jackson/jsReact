# Example 2. Explore R-JS interaction with plotly.js.
rm(list = ls())
library(jsReact)
library(magrittr)
my_html <- create_html() %>%
  add_js_library("plotly") %>%
  add_title("Send message") %>%
  add_slider(type = "range", id = "slide_input", min = "0", max = "100",
             oninput = "show_value(this.Value)") %>%
  add_title("Receive message") %>%
  add_div(id = "output") %>%
  add_div(id = "plotly_plot")
my_html %<>% add_script("
  function show_value() {
    var input = document.getElementById('slide_input');
    ws.send(input.value);
  }
  ws.onmessage = function(msg) {
    document.getElementById('output').innerHTML = msg.data;
    var data0 = JSON.parse(msg.data);
    var px = data0['x'][0];
    var py = data0['y'][0];
    var trace1 = {x: [px], y: [py], mode: 'markers', type: 'scatter'};
    var layout = {xaxis:{range: [-10, 10]}, yaxis: {range: [-20, 120]}};
    Plotly.newPlot('plotly_plot', [trace1], layout);
  }
")
my_r_fun <- function(msg) {
  list(x = rnorm(1), y = as.numeric(msg))
}
write_html_to_file(my_html, file = "inst/sample.html")
my_app <- create_app("inst/sample.html", user_function = my_r_fun)
start_app(my_app)
