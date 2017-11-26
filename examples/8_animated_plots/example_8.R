# In example 2, we learnt about using slider with plotly. What good does it do us?
# In this example, we reproduce Han Rosling's famous data visualisation.
rm(list = ls())
library(jsReact)
library(magrittr)


# Create data
library(tweenr)
df <- tweenr_example()
plot_df <- tween_elements(df, 'time', 'id', 'ease', nframes = 500)
plot_df$alpha <- plot_df$alpha / max(plot_df$alpha)  # cater for plotly


# Create web interface (html)
my_html <- create_html() %>%
  add_js_library("plotly") %>%
  add_title("Frame slider") %>%
  add_slider(min = "0", max = "500", value = "0", oninput = "send_value(value)",
             style = "width: 30em") %>%
  add_title("Plotly plot") %>%
  add_div(id = "plotly_plot")
my_html %<>% add_script("
  ws.onopen = function() {
    ws.send(JSON.stringify({init: true}));
  }
  function send_value(value) {
    ws.send(value);  // sends a frame value to R
  }
  var plot_xrange, plot_yrange;
  ws.onmessage = function(msg) {
    var data0 = JSON.parse(msg.data);
    if (data0.init == 'true') {
      plot_xrange = data0.xrange;
      plot_yrange = data0.yrange;
    } else {
      var trace1 = {
        x: data0.x, y: data0.y, mode: 'markers', type: 'scatter',
        marker: { size: data0.size, opacity: data0.alpha }
      };
      var layout = {
        xaxis: {range: plot_xrange}, yaxis: {range: plot_yrange},
        margin: {t:10, l:30}
      };
      Plotly.newPlot('plotly_plot', [trace1], layout);
    }
  }
")


has_init <- function(msg) {'init' %in% names(msg)}

# Create the R function to handle the interaction calculation
my_r_fun <- function(msg) {
  if (has_init(msg)) {
    to_js <- list(
      init = "true",
      xrange = range(plot_df$x) + c(-1, 1) * 0.5,
      yrange = range(plot_df$y) + c(-1, 1)
    )
  } else {
    # use function binding if one doesn't like lexical scoping
    to_js <- plot_df %>% dplyr::filter(.frame == msg) %>% as.list() %>%
      append(list(init = "false"))
  }
  to_js
}


# Create and start app
preview_app(my_html, my_r_fun, T)
