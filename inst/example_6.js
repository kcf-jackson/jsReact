// Data, reactive behaviour and global functions
var writing_data = {'x':[], 'y': [], 'state': []};
var smooth_data = {'x':[], 'y': [], 'state': []};
var thin_data = {'x':[], 'y': [], 'state': []};
ws.onmessage = function(msg) {
  //var in_msg = JSON.parse(msg.data);
};
function clear_everything() {
  clear_canvas(canvas_1);
  clear_canvas(canvas_2);
  clear_canvas(canvas_3);
  writing_data = {'x':[], 'y': [], 'state': []};
  smooth_data = {'x':[], 'y': [], 'state': []};
  thin_data = {'x':[], 'y': [], 'state': []};
}
function data_len() {
  return writing_data.x.length;
}


// Common canvas functions
function setup_template(p, parent_id) {
  var my_canvas = p.createCanvas(p.canvas_width, p.canvas_height);
  my_canvas.parent(parent_id);
  clear_canvas(p);
}
function clear_canvas(p) {
  p.fill(255);
  p.rect(0, 0, p.canvas_width - 1, p.canvas_height - 1);
}
function in_canvas(p) {
  return ((0 <= p.mouseX) && (p.mouseX <= p.canvas_width) &&
    (0 <= p.mouseY) && (p.mouseY <= p.canvas_height));
}
function plot_point(p, data0, current_pt) {
  var last_pt = current_pt - 1;
  p.fill(0);
  p.ellipse(data0.x[current_pt], data0.y[current_pt], 5, 5);
  if (last_pt >= 0) {
    var is_start_pt = (data0.state[last_pt] == 2);
    if (!is_start_pt) {
      p.line(data0.x[last_pt], data0.y[last_pt],
             data0.x[current_pt], data0.y[current_pt]);
    }
  }
}
function plot(p, data0) {
  for (var i = 0; i < data0.x.length; i++) {
    plot_point(p, data0, i);
  }
}


// Calculation of effects - smoothing and thinning
function smooth_it(writing_data, p) {
  var smooth_data = JSON.parse(JSON.stringify(writing_data));
  for (var i = 1; i < data_len(); i++) {
    smooth_data.x[i] = smooth_data.x[i-1] * p + writing_data.x[i] * (1-p);
    smooth_data.y[i] = smooth_data.y[i-1] * p + writing_data.y[i] * (1-p);
  }
  return smooth_data;
}
function thin_it(smooth_data, param) {
  var thin_data = {'x':[], 'y': [], 'state': []};
  thin_data.x.push(smooth_data.x[0]);
  thin_data.y.push(smooth_data.y[0]);
  thin_data.state.push(smooth_data.state[0]);
  for (var i = 1; i < data_len(); i++) {
    var last = thin_data.x.length - 1;
    var dx = Math.abs(smooth_data.x[i] - thin_data.x[last]);
    var dy = Math.abs(smooth_data.y[i] - thin_data.y[last]);
    if ((dx >= param) || (dy >= param)) {
      thin_data.x.push(smooth_data.x[i]);
      thin_data.y.push(smooth_data.y[i]);
      thin_data.state.push(smooth_data.state[i]);
    }
  }
  return thin_data;
}


// Canvas 1 - The main drawing panel.
var canvas_1_spec = function(p) {
  p.canvas_width = 600;
  p.canvas_height = 140;
  p.setup = function() {
    setup_template(p, 'db');
  };
  // interaction
  p.mouseDragged = function() {
    if (in_canvas(p)) {
      writing_data.x.push(p.mouseX);
      writing_data.y.push(p.mouseY);
      writing_data.state.push(1);
      plot_point(p, writing_data, data_len() - 1);
    }
  };
  p.mouseReleased = function() {
    // Ending point of a stroke
    writing_data.state[data_len() - 1] = 2;
    console.log(writing_data);
  };
};


// Canvas 2 the smoothing panel
var canvas_2_spec = function(p) {
  p.canvas_width = 600;
  p.canvas_height = 140;
  p.setup = function() {
    setup_template(p, 'db_2');
  };
};
function slider_smooth(param) {
  clear_canvas(canvas_2);
  smooth_data = smooth_it(writing_data, param);
  plot(canvas_2, smooth_data);
}


// Canvas 3 the thinning panel
var canvas_3_spec = function(p) {
  p.canvas_width = 600;
  p.canvas_height = 140;
  p.setup = function() {
    setup_template(p, 'db_3');
  };
};
function slider_thin(param) {
  clear_canvas(canvas_3);
  thin_data = thin_it(smooth_data, param);
  plot(canvas_3, thin_data);
}


// Initiate canvas
var canvas_1 = new p5(canvas_1_spec, "cid_1");
var canvas_2 = new p5(canvas_2_spec, "cid_2");
var canvas_3 = new p5(canvas_3_spec, "cid_3");
