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
      if ((nx + i < box_num) && (ny + j < box_num) && 
          (nx + i >= 0) && (ny + j >= 0)) {
        update_data.nx.push(nx + i);
        update_data.ny.push(ny + j);
        update_data.mod_index.push((nx + i) * box_num + (ny + j));
      }
    }
  }
  return update_data;
}


function nearest_id(coord, box_size) {
  return Math.floor(coord / box_size);
}


function far_apart(coord_1, coord_2, d = 5) {
  return (is_far(coord_1.x, coord_2.x, d) || is_far(coord_1.y, coord_2.y, d));
}


function is_far(coord_1, coord_2, d = 5) {
  return (Math.abs(coord_1 - coord_2) > d);
}


function initialise_mini_grid(p, init_data, id) {
  var col = init_data[id];
  p.grid_data.y = col.map(x => p.map(x, Math.min(...col), Math.max(...col), 0, 255));
  colorful_plot_grid(p, p.grid_data);
}


function get_mousePos_pixels(p) {
  var nx = nearest_id(p.mouseX, p.box_dim);
  var ny = nearest_id(p.mouseY, p.box_dim);
  var neighbor = 1;  // implementing brush
  return get_neighbor(nx, ny, neighbor);
}


function as_vector(list0) {
  return Object.keys(list0).map(x => list0[x]);
}
