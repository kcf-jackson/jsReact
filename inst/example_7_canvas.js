main_canvas_spec = function(p) {
  p.box_dim = 15;
  p.canvas_dim = box_num * p.box_dim;
  p.canvas_width = p.canvas_dim + 1;
  p.canvas_height = p.canvas_dim + 1;
  p.setup = function() {
    var my_canvas = p.createCanvas(p.canvas_width, p.canvas_height);
    my_canvas.parent('column_1');
    p.rect(0, 0, p.canvas_width+1, p.canvas_height+1);
    p.plot_grid();
  };
  p.plot_grid = function() {
    grid_data = uniform_grid(0, p.canvas_dim - p.box_dim, box_num);
    for (var i = 0; i < grid_data.y.length; i++) {
      p.fill(196, 218, 255);
      p.rect(grid_data.x1[i], grid_data.x2[i], p.box_dim, p.box_dim);
    }
  };
  p.draw = function() {
    if (p.mouseIsPressed) {
      if (p.keyIsPressed) {
        update_grid(p, 0);
      } else {
        update_grid(p, 1);
      }
    }
  };
  p.mouseReleased = function() {
    ws.send(JSON.stringify(grid_data.y));
  };
};
