rm(list = ls())
library(jsReact)
library(magrittr)
my_html <- create_html() %>%
  add_js_library(c("plotly", "p5")) %>%
  add_style(
    "<style type='text/css'>
      .column { float:left; }
      h3 { margin-top: 2cm; }
    </style>") %>%
  add_row(id = "row_1") %>%
  add_column(id = "column_1") %>%
  add_title("Parameter domain", after = "column_1") %>%
  add_column(id = "column_2") %>%
  add_div(id = "plotly_plot", after = "column_2")


my_html %<>% add_script(
"<script>
  ws.onmessage = function(msg) {
    var data0 = JSON.parse(msg.data);
    var trace1 = {
      x: data0['x'], y: data0['y'],
      mode: 'markers', type: 'scatter'
    };
    var layout = {
      title: 'Geometry of the sigmoid function',
      xaxis: {range: [-100, 100]},
      yaxis: {range: [-0.5, 1.5]}
    };
    Plotly.newPlot('plotly_plot', [trace1], layout);
  }
</script>") %>% add_script(
"<script>
  var canvas_width = canvas_height = 200
  function setup() {
    var my_canvas = createCanvas(canvas_width, canvas_height);
    my_canvas.parent('column_1');
    draw_bg()
  }
  function draw() {
    if (mouseIsPressed) {
      draw_bg()
      draw_pt()
    }
  }
  function draw_bg() {
    rect(0, 0, canvas_width-1, canvas_height-1);
    line(canvas_width / 2, 0, canvas_width / 2, canvas_height)
    line(0, canvas_height / 2, canvas_width, canvas_height / 2)
  }
  function draw_pt() {
    ellipse(mouseX, mouseY, 10, 10);
    var json_msg_to_r = {
      'x': map(mouseX, 0, canvas_width, -1, 1),
      'y': map(mouseY, canvas_height, 0, -1, 1)
    };
    ws.send(JSON.stringify(json_msg_to_r));
  }
</script>")

my_r_fun <- function(msg) {
  beta_1 <- msg$x * 10
  beta_2 <- msg$y
  x <- seq(-100, 100, length.out = 100)
  y <- boot::inv.logit(beta_1 + beta_2 * x)
  list(x = x, y = y)
}

write_html_to_file(my_html, "inst/sample.html")
my_app <- create_app("inst/sample.html", my_r_fun)
start_app(my_app)
