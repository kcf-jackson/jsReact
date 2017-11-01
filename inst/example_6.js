// Data and reactive behaviour
var writing_data = {'x':[], 'y': [], 'state': []};
var smooth_data = {'x':[], 'y': [], 'state': []};
var thin_data = {'x':[], 'y': [], 'state': []};
ws.onmessage = function(msg) {
  //var in_msg = JSON.parse(msg.data);
};

// Canvas setup
var canvas_width = 600;
var canvas_height = 140;
function setup() {
  var my_canvas = createCanvas(canvas_width, canvas_height);
  my_canvas.parent('drawing_box');
  clear_canvas();
}
function clear_canvas() {
  fill(255);
  rect(0, 0, canvas_width - 1, canvas_height - 1);
}
function in_canvas() {
  return ((0 <= mouseX) && (mouseX <= canvas_width) &&
    (0 <= mouseY) && (mouseY <= canvas_height));
}
function data_len() {
  return writing_data.x.length;
}
function plot_last_point(writing_data) {
  var current_pt = data_len() - 1;
  var last_pt = current_pt - 1;
  // Draw points and lines
  fill(0);
  ellipse(writing_data.x[current_pt], writing_data.y[current_pt], 5, 5);
  if (last_pt >= 0) {
    var is_start_pt = (writing_data.state[last_pt] == 2);
    if (!is_start_pt) {
      line(writing_data.x[last_pt], writing_data.y[last_pt],
           writing_data.x[current_pt], writing_data.y[current_pt]);
    }
  }
}
function plot_data(writing_data, color) {}
function mouseDragged() {
  if (in_canvas()) {
    writing_data.x.push(mouseX);
    writing_data.y.push(mouseY);
    writing_data.state.push(1);
    plot_last_point(writing_data);
  }
}
function mouseReleased() {
  // Ending point of a stroke
  writing_data.state[data_len() - 1] = 2;
  console.log(writing_data);
}
// Canvas behaviour
function slider_smooth(param) {
  smooth_data = writing_data;
  console.log(param);
  for (var i = 1; i < data_len(); i++) {
    smooth_data.x[i] = smooth_data.x[i-1] * (1 - param) + writing_data.x[i] * param;
    smooth_data.y[i] = smooth_data.y[i-1] * (1 - param) + writing_data.y[i] * param;
    // draw on new canvas
    // clear_canvas();
    // plot_data(writing_data, 50);
    // plot_data(smooth_data, 0);
  }
}
function thin(param) {

}
/*
plot_data();
function plot_data() {
  for (var i = 0; i < writing_data.x.length; i++) {
    ellipse(writing_data.x[i], writing_data.y[i], 10, 10);
    if (i < writing_data.x.length - 1) {

    }
  }
}
*/
