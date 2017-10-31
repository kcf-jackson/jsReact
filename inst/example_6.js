// Data and reactive behaviour
var writing_data = {'x':[], 'y': []};
ws.onmessage = function(msg) {
  //var in_msg = JSON.parse(msg.data);
};
// Canvas setup
var canvas_width = 600;
var canvas_height = 120;
function setup() {
  var my_canvas = createCanvas(canvas_width, canvas_height);
  my_canvas.parent('column_1');
  rect(0, 0, canvas_width - 1, canvas_height - 1);
}
function mousePressed() {
  if (writing_data.x.length === 0) {
    writing_data.x.push(mouseX);
    writing_data.y.push(mouseY);
  }
}
function mouseDragged() {
  writing_data.x.push(mouseX);
  writing_data.y.push(mouseY);
  var i = writing_data.x.length;
  ellipse(writing_data.x[i-1], writing_data.y[i-1], 10, 10);
  line(writing_data.x[i-2], writing_data.y[i-2],
       writing_data.x[i-1], writing_data.y[i-1]);
}
// Canvas behaviour
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
