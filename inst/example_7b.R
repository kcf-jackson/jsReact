# In example 2, we learnt about using slider with plotly. What can we use it for?
# In this example, we reproduce Han Rosling's wealth & health of nations.
rm(list = ls())
library(jsReact)
library(magrittr)


# Create frame from the data
library(gapminder)
plot_df <- gapminder %>%
  dplyr::rename(time = year, id = country) %>%
  dplyr::mutate(ease = "linear") %>%
  tween_elements("time", "id", "ease", nframes = 120)


# Create web interface (html)
my_html <- create_html() %>%
  add_js_library(c("plotly", "d3")) %>%
  add_title("Frame slider") %>%
  add_slider(type = "range", id = "slide_input", min = "0", max = "120", value = "0",
             step = "1", oninput = "send_value(this.Value)") %>%
  add_title("Plotly plot") %>%
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
    var radiusScale = d3.scaleSqrt().domain([0, 5e8]).range([0, 40]);
    var colorScale = d3.scaleOrdinal(d3.schemeCategory10);
    var trace1 = {
      x: data0.gdpPercap, y: data0.lifeExp, text: data0['.group'],
      marker: { size: data0.pop.map(x => radiusScale(x)),
                color: data0.continent.map(x => colorScale(x)) },
      mode: 'markers', type: 'scatter'
    };
    var layout = {
      xaxis: {range: [data0.plot_range.xmin[0], data0.plot_range.xmax[0]], type: 'log'},
      yaxis: {range: [data0.plot_range.ymin[0], data0.plot_range.ymax[0]]},
      margin: {t:10, l:30}
    };
    Plotly.newPlot('plotly_plot', [trace1], layout);
    var myPlot = document.getElementById('plotly_plot');
  };
")
write_html_to_file(my_html, file = "inst/sample.html")


# Create the R function to handle the interaction calculation
my_r_fun <- function(msg) {
  # use function binding if one doesn't like calling to global variable
  prange <- list(plot_range = list(
    xmin = log10(min(plot_df$gdpPercap)), xmax = log10(max(plot_df$gdpPercap)),
    ymin = min(plot_df$lifeExp), ymax = max(plot_df$lifeExp)
  ))
  plot_df %>%
    dplyr::filter(.frame == msg) %>%
    as.list() %>%
    append(prange)
}


# Create and start app
my_app <- create_app("inst/sample.html", user_function = my_r_fun)
start_app(my_app)

# Comments: for hovertext, use paste0 and create a new column in the data using R.
