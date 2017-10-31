// Data and reactive behaviour
var writing_data = {'x':[], 'y': [], 'state': []};
ws.onmessage = function(msg) {
  //var in_msg = JSON.parse(msg.data);
};
// Canvas setup
var canvas_width = 600;
var canvas_height = 140;
function setup() {
  var my_canvas = createCanvas(canvas_width, canvas_height);
  my_canvas.parent('column_1');
  rect(0, 0, canvas_width - 1, canvas_height - 1);
}
function mousePressed() {
  // Starting point of a stroke
  var len = writing_data.x.length;
  writing_data.x.push(mouseX);
  writing_data.y.push(mouseY);
  writing_data.state.push(0);
}
function mouseReleased() {
  // Ending point of a stroke
  writing_data.x.push(mouseX);
  writing_data.y.push(mouseY);
  writing_data.state.push(2);
  console.log(writing_data);
}
function mouseDragged() {
  writing_data.x.push(mouseX);
  writing_data.y.push(mouseY);
  writing_data.state.push(1);
  var current_pt = writing_data.x.length - 1;
  var last_pt = current_pt - 1;
  fill(0);
  ellipse(writing_data.x[current_pt], writing_data.y[current_pt], 5, 5);
  var is_start_pt = (writing_data.state[current_pt] === 0);
  if (!is_start_pt) {
    line(writing_data.x[last_pt], writing_data.y[last_pt],
         writing_data.x[current_pt], writing_data.y[current_pt]);
  }
}
