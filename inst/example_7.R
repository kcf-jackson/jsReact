# In example 2, we learnt about using slider with plotly. What good does it do us?
# In this example, we reproduce Han Rosling's famous data visualisation.
rm(list = ls())
library(jsReact)
library(magrittr)


library(tweenr)
df <- tweenr_example()
plot_df <- tween_elements(df, 'time', 'id', 'ease', nframes = 500)
plot_df$alpha <- plot_df$alpha / max(plot_df$alpha)  # cater for plotly


# Create web interface (html)
my_html <- create_html() %>%
  add_js_library("plotly") %>%
  add_title("Frame slider") %>%
  add_slider(type = "range", id = "slide_input", min = "0", max = "500", value = "0",
             oninput = "send_value(this.Value)") %>%
  add_title("Plotly plot") %>%
  #add_div(id = "output") %>%
  add_div(id = "plotly_plot") %>%
  add_style("input#slide_input { width: 30em; }")

my_html %<>% add_script("
  function send_value(input) {
    // this function sends the frame value to R.
    var input = document.getElementById('slide_input');
    ws.send(input.value);
  }
  ws.onmessage = function(msg) {
    // this function gets the plot data from R.
    var data0 = JSON.parse(msg.data);
    var trace1 = {
      x: data0.x, y: data0.y,
      marker: { size: data0.size, opacity: data0.alpha },
      mode: 'markers', type: 'scatter'
    };
    var layout = {
      xaxis: {range: [Math.min(...data0.plot_range.xmin), Math.max(...data0.plot_range.xmax)]},
      yaxis: {range: [Math.min(...data0.plot_range.ymin), Math.max(...data0.plot_range.ymax)]},
      margin: {t:10, l:30}
    };
    Plotly.newPlot('plotly_plot', [trace1], layout);
  }
")
write_html_to_file(my_html, file = "inst/sample.html")


# Create the R function to handle the interaction calculation
my_r_fun <- function(msg) {
  # use function binding if one doesn't like calling to global variable
  to_js <- as.list(plot_df %>% dplyr::filter(.frame == msg)) %>%
    append(list(plot_range = list(
      xmin = min(plot_df$x) - 0.5, xmax = max(plot_df$x) + 0.5,
      ymin = min(plot_df$y) - 1, ymax = max(plot_df$y) + 1
    )))
  to_js
}


# Create and start app
my_app <- create_app("inst/sample.html", user_function = my_r_fun)
start_app(my_app)
