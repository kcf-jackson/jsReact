var dists;
var tsne;
var min_x = 0, min_y = 0, max_x = 0, max_y = 0;
var train = false;

ws.onopen = function() {
  ws.send(JSON.stringify({status: 'initialising'}));
};
ws.onmessage = function(msg) {
  var data0 = JSON.parse(msg.data);
  dists = data0.r_dist_matrix;
  setup_tsne();
  setInterval(run_tsne, 100);
};

setup_tsne = function() {
  var opt = {};
  opt.epsilon = document.getElementById("lr").value; // epsilon is learning rate
  opt.perplexity = document.getElementById("perp").value; // roughly how many neighbors each point influences
  opt.dim = 2;         // dimensionality of the embedding (2 = default)
  tsne = new tsnejs.tSNE(opt); // create a tSNE instance
  tsne.initDataDist(dists);
};
run_tsne = function() {
  if (train) {
    tsne.step(); // every time you call this, solution gets better
    plot_ly(tsne.getSolution());
  }
};
plot_ly = function(data0) {
  var x = data0.map(x => x[0]);
  var y = data0.map(x => x[1]);
  min_x = Math.min(min_x, Math.min(...x));
  max_x = Math.max(max_x, Math.max(...x));
  min_y = Math.min(min_y, Math.min(...y));
  max_y = Math.max(max_y, Math.max(...y));
  var trace1 = {x: x, y: y, mode: 'markers', type: 'scatter'};
  var layout = {
    height: 500, width: 500,
    xaxis: {range: [min_x, max_x], showticklabels: false},
    yaxis: {range: [min_y, max_y], showticklabels: false},
    margin: {t:30, b:30, l:30, r:30}
  };
  Plotly.newPlot('plotly_plot', [trace1], layout);
};
function stop() {
  train = false;
}
function keep_going() {
  train = true;
}
