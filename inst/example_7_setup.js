var init_data = [];
var box_num = 28;
var pred_data = {'class': [], 'prob': []};
var global_hover_data = {nx:[], ny: [], mod_index: []};
var global_hover_sum = {'0':0, '1':0, '2':0, '3':0, '4':0, '5':0, '6':0, '7':0, '8':0, '9':0};


ws.onmessage = function(msg) {
  var in_msg = JSON.parse(msg.data);
  if (in_msg.init == 'true') {
    init_data = in_msg.data;
    var ids = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    var canvas_list = [mini_0_canvas, mini_1_canvas, mini_2_canvas, mini_3_canvas, mini_4_canvas, mini_5_canvas, 
                        mini_6_canvas, mini_7_canvas, mini_8_canvas, mini_9_canvas];
    for (var i = 0; i < ids.length; i++) {
      initialise_mini_grid(canvas_list[i], init_data, ids[i]);
    }
  } else {
    usual_data = in_msg;
    update_table(in_msg.table); 
  }
};


ws.onopen = function() {
  ws.send(JSON.stringify({init: true}));  
};


// Common canvas functions
function update_grid_data(p, mousePixels, value) {
  var plot_data = {x1: [], x2: [], y:[]};
  for (var k = 0; k < mousePixels.nx.length; k++) {
    var mi = mousePixels.mod_index[k];
    p.grid_data.y[mi] = value;
    plot_data.x1.push(p.grid_data.x1[mi]);
    plot_data.x2.push(p.grid_data.x2[mi]);
    plot_data.y.push(value);
  }
  plot_grid(p, plot_data);
}


function plot_grid(p, grid_data) {
  for (var i = 0; i < grid_data.y.length; i++) {
    if (grid_data.y[i] == 1) {
      p.fill(0, 0, 0);
    } else if (grid_data.y[i] == 0.5) {
      p.fill(176, 198, 235);
    } else {
      //p.fill(196, 218, 255);
      p.fill(255, 255, 255);
    }
    p.rect(grid_data.x1[i], grid_data.x2[i], p.box_dim, p.box_dim);
  }
};


function update_hover_data(p, value) {
  if (p.hover_data.x1.length !== 0) {
    // restore previous color
    for (var k = 0; k < p.hover_data.x1.length; k++) {
      p.hover_data.y[k] = p.grid_data.y[p.hover_data.ypos[k]];
    }  
    plot_grid(p, p.hover_data);
  }
  if (global_hover_data.nx.length !== 0) {
    p.hover_data = {x1: [], x2: [], y:[], ypos:[]};
    for (var k = 0; k < global_hover_data.nx.length; k++) {
      if ((global_hover_data.nx[k] < box_num) && (global_hover_data.ny[k] < box_num)) {
        var mi = global_hover_data.mod_index[k];
        p.hover_data.x1.push(p.grid_data.x1[mi]);
        p.hover_data.x2.push(p.grid_data.x2[mi]);
        p.hover_data.ypos.push(mi);
        p.hover_data.y.push(value);
      }
    }
    plot_grid(p, p.hover_data);
  }
}


function colorful_plot_grid(p, grid_data) {
  for (var i = 0; i < grid_data.y.length; i++) {
    var r = 255;
    var g = 255 - grid_data.y[i];
    var b = 0 + (255 - 0) * (1 - grid_data.y[i] / 255);
    p.fill(g, b, r);
    p.rect(grid_data.x1[i], grid_data.x2[i], p.box_dim, p.box_dim);
  }
};


function colorful_update_hover_data(p, value) {
  if (p.hover_data.x1.length !== 0) {
    // restore previous color
    for (var k = 0; k < p.hover_data.x1.length; k++) {
      p.hover_data.y[k] = p.grid_data.y[p.hover_data.ypos[k]];
    }  
    colorful_plot_grid(p, p.hover_data);
  }
  if (global_hover_data.nx.length !== 0) {
    p.hover_data = {x1: [], x2: [], y:[], ypos:[]};
    p.hover_sum = 0;
    for (var k = 0; k < global_hover_data.nx.length; k++) {
      if ((global_hover_data.nx[k] < box_num) && (global_hover_data.ny[k] < box_num)) {
        var mi = global_hover_data.mod_index[k];
        p.hover_data.x1.push(p.grid_data.x1[mi]);
        p.hover_data.x2.push(p.grid_data.x2[mi]);
        p.hover_data.ypos.push(mi);
        p.hover_data.y.push(value);
        p.hover_sum += init_data[p.id][mi];
      }
    }
    global_hover_sum[p.id] = p.hover_sum;
    console.log(global_hover_sum);
    colorful_plot_grid(p, p.hover_data);
  }
}
