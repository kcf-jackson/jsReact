ws.onmessage = function(msg) {
  var data0 = JSON.parse(msg.data);
  var trace1 = {
    x: data0['x'], y: data0['y'], mode: 'markers', type: 'scatter'
  };
  var layout = {
    title: 'Geometry of the sigmoid function',
    xaxis: {range: [-100, 100]}, yaxis: {range: [-0.5, 1.5]}
  };
  Plotly.newPlot('plotly_plot', [trace1], layout);
};
var canvas_width = 200, canvas_height = 200;
function setup() {
  var my_canvas = createCanvas(canvas_width, canvas_height);
  my_canvas.parent('p5_canvas');
  draw_bg();
}
function draw() {
  if (mouseIsPressed) {
    draw_bg();
    draw_pt();
  }
}
function draw_bg() {
  rect(0, 0, canvas_width-1, canvas_height-1);
  line(canvas_width / 2, 0, canvas_width / 2, canvas_height);
  line(0, canvas_height / 2, canvas_width, canvas_height / 2);
}
function draw_pt() {
  ellipse(mouseX, mouseY, 10, 10);
  var json_msg_to_r = {
    'x': map(mouseX, 0, canvas_width, -1, 1),
    'y': map(mouseY, canvas_height, 0, -1, 1)
  };
  ws.send(JSON.stringify(json_msg_to_r));
}
