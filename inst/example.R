# Example 1. This file explores the basic mechanism for R and JS to interact.
rm(list = ls())
library(jsReact)
library(magrittr)
my_html <- create_html() %>%
  add_title("Send message") %>%i
  add_slider(type = "range", id = "slide_input", min = "0", max = "100",
             oninput = "show_value(this.Value)") %>%
  add_title("Receive message") %>%
  add_div(id = "output")
my_html %<>% add_script(
  'function show_value() {
     var input = document.getElementById("slide_input");
     ws.send(input.value);
   }
   ws.onmessage = function(msg) {
     document.getElementById("output").innerHTML = msg.data;
   }')
write_html_to_file(my_html, file = "inst/sample.html")

my_app <- create_app("inst/sample.html", insert_socket = T)
start_app(my_app)
