var data0 = {'x1': [], 'x2': [], 'y': []};
var grid_data = {'x1': [], 'x2': [], 'y': []};
ws.onmessage = function(msg) {
  grid_data = JSON.parse(msg.data);
};

var canvas_width = 400;
var canvas_height = 400;
function setup() {
  var my_canvas = createCanvas(canvas_width, canvas_height);
  my_canvas.parent('column_1');
  rect(0, 0, canvas_width-1, canvas_height-1);
}
function draw() {
  plot_data(grid_data, 'bg');
  plot_data(data0, 'data');
}

function plot_data(data0, type) {
  var n = data0['x1'].length;
  for (var i = 0; i < n; i++) {
    if (data0['y'][i] == 1) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    if (type == 'bg') {
      rect(data0['x1'][i], data0['x2'][i], 20, 20);
    } else {
      ellipse(data0['x1'][i], data0['x2'][i], 10, 10);
    }
  }
}
function mouseClicked() {
  data0['x1'].push(mouseX);
  data0['x2'].push(mouseY);
  if (keyIsPressed === true) {
    data0['y'].push(1);
  } else {
    data0['y'].push(0);
  }
  ws.send(JSON.stringify(data0));
}
