#Example 1
rm(list = ls())
library(jsReact)
my_html <- create_html() %>%
  add_title("Send message") %>%
  add_slider("range", "slide_input", "0", "100", oninput = "show_value(this.Value)") %>%
  add_title("Receive message") %>%
  add_div(id = "output")
my_html %<>% add_script('
  <script>
    function show_value() {
      var input = document.getElementById("slide_input");
      ws.send(input.value);
    }
    ws.onmessage = function(msg) {
      document.getElementById("output").innerHTML = msg.data;
    }
  </script>
')
cat(my_html, file = "inst/sample.html")
my_app <- create_app("inst/sample.html", insert_socket = T)
start_app(my_app)
