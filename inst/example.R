# Example 1. This file explores the basic mechanism for R and JS to interact.
rm(list = ls())
library(jsReact)
library(magrittr)
my_html <- create_html() %>%
  add_title("Send message") %>%
  add_slider(min = "0", max = "100", oninput = "show_value(value)") %>%
  add_title("Receive message") %>%
  add_div(id = "output")
my_html %<>% add_script(
  'function show_value(value) {
     ws.send(value);
   }
   ws.onmessage = function(msg) {
     document.getElementById("output").innerHTML = msg.data;
   }')
write_html_to_file(my_html, file = "inst/sample.html")

r_fun <- function(msg) {
  print(msg)
}

my_app <- create_app("inst/sample.html", r_fun, insert_socket = T)
start_app(my_app)
