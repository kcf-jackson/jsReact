// Define behaviour for each of the 5 classes of widgets 
// - Classification table
function update_table(prediction_table) {
  document.getElementById("result_table").innerHTML = prediction_table;  
}


// - Button
function clear_everything() {
  main_canvas.grid_data = uniform_grid(0, main_canvas.canvas_dim - main_canvas.box_dim, box_num);
  plot_grid(main_canvas, main_canvas.grid_data);
}


// - Mini canvas
spec_builder = function(parent_id, digit) {
  var mini_canvas_spec = function(p) {
    p.id = digit;
    p.box_dim = 6;
    p.canvas_dim = box_num * p.box_dim;
    p.canvas_width = p.canvas_height = p.canvas_dim + 1;
    p.grid_data = uniform_grid(0, p.canvas_dim - p.box_dim, box_num);
    p.hover_data = {x1: [], x2: [], y:[], ypos:[]};
    p.hover_sum = 0;
    p.setup = function() {
      var my_canvas = p.createCanvas(p.canvas_width, p.canvas_height);
      my_canvas.parent(parent_id);
      p.rect(0, 0, p.canvas_width, p.canvas_height);
    };
    p.draw = function() {
      colorful_update_hover_data(p, 0.5);
    };
  };
  return mini_canvas_spec;
}


// - Main canvas
main_canvas_spec = function(p) {
  // setup
  p.box_dim = 12;
  p.canvas_dim = box_num * p.box_dim;
  p.canvas_width = p.canvas_height = p.canvas_dim + 1;
  // data
  p.grid_data = uniform_grid(0, p.canvas_dim - p.box_dim, box_num);
  p.hover_data = {x1: [], x2: [], y:[], ypos:[]};
  p.mouse_track = {x: 0, y: 0};
  // functions
  p.setup = function() {
    var my_canvas = p.createCanvas(p.canvas_width, p.canvas_height);
    my_canvas.parent('column_1');
    p.rect(0, 0, p.canvas_dim, p.canvas_dim);
    plot_grid(p, p.grid_data);
  };
  p.draw = function() {
    // Mouse drag
    if (p.mouseIsPressed) {
      var mousePixels = get_mousePos_pixels(p);
      global_hover_data = mousePixels;
      if (p.keyIsPressed) {
        update_grid_data(p, mousePixels, 0);
      } else {
        update_grid_data(p, mousePixels, 1);
      }
      update_digit_gain_widget();      
    } 
    var fps = p.frameRate();
    p.fill(255);
    p.stroke(0);
    p.text("FPS: " + fps.toFixed(2), 10, p.canvas_height - 10);
  };
  p.mouseMoved = function() {
    // Mouse hover
    var mousePos = {x: p.mouseX, y: p.mouseY};
    if (far_apart(p.mouse_track, mousePos, 3)) {
      global_hover_data = get_mousePos_pixels(p);
      update_hover_data(p, 0.5);
      p.mouse_track = mousePos;
      update_digit_gain_widget();
    }
  };
  p.mouseReleased = function() {
    ws.send(JSON.stringify(p.grid_data.y));
  };
};


// - Pixel gain
update_digit_gain_widget = function() {
  var plotly_data = [{
    x: [0,1,2,3,4,5,6,7,8,9],
    y: as_vector(global_hover_sum),
    type: 'bar',
    marker: {color: 'rgb(255, 119, 137)'}
  }];
  var plotly_layout = {
    width: 360, height: 250,
    margin: {l: 50, r: 10, b: 25, t: 30},
    xaxis: {dtick: 1},
    yaxis: {range: [-Math.max(...plotly_data[0].y), 1.2 * Math.max(...plotly_data[0].y)]},
    title: "Pixel scores for / against <br> classification of each digit"
  };
  Plotly.newPlot('digit_gain', plotly_data, plotly_layout);
}
