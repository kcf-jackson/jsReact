vr_obj_file <- function(filepath) {
  require(magrittr)
  require(jsReact)
  get_filename <- . %>% strsplit("/") %>% unlist() %>% tail(1)
  obj_file <- get_filename(filepath)
  create_html() %>%
    add_title("Hello, WebVR in R!") %>%
    add_script_from_link("https://aframe.io/releases/0.7.0/aframe.min.js") %>%
    add_vr_scene(id = "vr_scene", width = "800", height = "983") %>%
    add_vr_assets(into = "vr_scene", id = "assets") %>%
    add_vr_asset_item(id = "tree-obj", src = obj_file, into = "assets") %>%
    add_vr_entity("obj-model" = "obj: #tree-obj;",
                  position = "0 1.5 -1.5",
                  rotation = "0 0 0",
                  scale = "0.01 0.01 0.01", into = "vr_scene",
                  material="color: gray; opacity: 0.5") %>%
    preview_app(assets_folder = filepath, port = 9450)
}

# File reference: https://brainder.org/research/brain-for-blender/
# Download "Full hemispheres, each as a single mesh" -> "PIAL" -> "OBJ" and unzip it.
obj_file <- "others/assets/rh.pial.obj"
vr_obj_file(obj_file)
