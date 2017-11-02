ws.onmessage = function(msg) {
  //first time setup
  // if (first_time) {
  //
  // } else {
  var in_msg = JSON.parse(msg.data).table;
  document.getElementById("result_table").innerHTML = in_msg;
  //pred_data = in_msg.pred;
  // }
};


function uniform_grid(min, max, num_box) {
  var x1 = seq(min, max, null, num_box);
  var grid_data = {'x1': [], 'x2': [], 'y': []};
  for (var i = 0; i < x1.length; i++) {
    grid_data.x1 = grid_data.x1.concat(rep(x1[i], num_box));
    grid_data.x2 = grid_data.x2.concat(x1);
    grid_data.y = grid_data.y.concat(rep(0, num_box));
  }
  return grid_data;
}


function get_neighbor(nx, ny, neighbor) {
  var update_data = {nx: [], ny: [], mod_index: []};
  for (var i = -neighbor; i <= neighbor; i++) {
    var bdy = neighbor - Math.abs(i);
    for (var j = -bdy; j <= bdy; j++) {
      update_data.nx.push(nx + i);
      update_data.ny.push(ny + j);
      update_data.mod_index.push((nx + i) * box_num + (ny + j));
    }
  }
  return update_data;
}


function nearest_id(coord, box_size) {
  return Math.floor(coord / box_size);
}


// Common canvas functions
function color(p, update_data, value) {
  for (var k = 0; k < update_data.nx.length; k++) {
    var mi = update_data.mod_index[k];
    if ((update_data.nx[k] <= 27) & (update_data.ny[k] <= 27)) {
      grid_data.y[mi] = value;
      if (grid_data.y[mi] == 1) {
        p.fill(255, 255, 255);
      } else {
        p.fill(196, 218, 255);
      }
      p.rect(grid_data.x1[mi], grid_data.x2[mi], 15, 15);
    }
  }
}


function update_grid(p, value) {
  var n = grid_data.x1.length;
  var nx = nearest_id(p.mouseX, p.box_dim);
  var ny = nearest_id(p.mouseY, p.box_dim);
  var neighbor = 1;  // implementing brush
  var brush_data = get_neighbor(nx, ny, neighbor);
  color(p, brush_data, value);     
}


var box_num = 28;
var pred_data = {'class': [], 'prob': []};
var grid_data = uniform_grid(0, 420 - 15, box_num);
var hover_data = uniform_grid();
