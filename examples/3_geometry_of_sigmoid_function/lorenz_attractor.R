my_html <- create_html() %>%
  add_js_library('p5') %>%
  add_script(
"function setup() {
  createCanvas(800, 800); //width, height
}

var sigma = 10, beta = 8/3, rho = 28;
var x = 1, y = 1, z = 1, dt = 0.015;
var new_x, new_y, new_z;
function draw() {
  // Lorenz system
  new_x = x + (sigma * (y-x)) * dt;
  new_y = y + (x * (rho - z) - y) * dt;
  new_z = z + (x * y - beta * z) * dt;
  x = new_x, y = new_y, z = new_z;
  // Plot
  fill(color(255 - map(z, 0, 80, 0, 255), 0, 0));
  ellipse(200 + 5 * x, 200 + 5 * y, 10);    //circle: x, y, radius
}
")

preview_app(my_html)
