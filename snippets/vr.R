vr <- function(df0) {
  require(magrittr)
  require(jsReact)
  create_html() %>%
    add_title("Hello, WebVR in R!") %>%
    add_script_from_link("https://aframe.io/releases/0.7.0/aframe.min.js") %>%
    add_vr_scene(id = "vr_scene", width = "800", height = "983") %>%
    add_vr_3d_points(into = "vr_scene", df0 = df0) %>%
    preview_app()
}

df0 <- data.frame(x = runif(10, 1, 10), y = runif(10, 1, 10), z = runif(10, -10, -1))
vr(df0)
