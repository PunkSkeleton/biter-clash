--data.lua

require("data.items")
require("data.enemies.biters")
require("data.enemies.spitters")
require("data.enemies.nests")
require("data.enemies.nestItems")
require("data.weapons")
require("data.research")
require("data.upgrades")
require("data.sprites")

data:extend({
  {
    type = "shortcut",
    name = "biter-clash",
    localised_name = { "shortcut.biter-clash"},
    order = "b[blueprints]-f[book]",
    action = "lua",
    style = "green",
    icon = {
      filename = "__biter-clash__/graphics/biter.png",
      flags = {
        "icon"
      },
      priority = "extra-high-no-scale",
      scale = 1,
      size = 32
    },
    small_icon = {
      filename = "__biter-clash__/graphics/biter.png",
      flags = {
        "icon"
      },
      priority = "extra-high-no-scale",
      scale = 1,
      size = 24
    },
    disabled_small_icon = {
      filename = "__biter-clash__/graphics/biter.png",
      flags = {
        "icon"
      },
      priority = "extra-high-no-scale",
      scale = 1,
      size = 24
    },
  },
})

data.raw["gui-style"]["default"]["biter-clash_frame"] =
{
    type = "frame_style",
    parent = "frame",
    maximal_width = 400,
}
data.raw["gui-style"]["default"]["biter-clash_label_multiline"] =
{
    type = "label_style",
    parent = "label",
    maximal_width = 400,
    single_line = false,
}
data.raw["gui-style"]["default"]["biter-clash_radiobutton"] =
{
    type = "radiobutton_style",
    parent = "radiobutton",
    top_margin = 5,
    bottom_margiin = 5,
    left_margin = 5,
    right_margin = 5
}
data.raw["gui-style"]["default"]["biter-clash_help"] =
{
    type = "label_style",
    parent = "label",
    maximal_width = 400,
    single_line = false,
    font = "default-large"
}
data.raw["gui-style"]["default"]["biter-clash_period"] =
{
    type = "button_style",
    parent = "rounded_button",
    width = 100,
    font = "default-large"
}
data.raw["gui-style"]["default"]["biter-clash_production_icon"] =
{
    type = "label_style",
    parent = "biter-clash_help",
    width = 40,
    single_line = true
}
data.raw["gui-style"]["default"]["biter-clash_production_value"] =
{
    type = "label_style",
    parent = "biter-clash_help",
    width = 100,
    single_line = true,
    horizontal_align = "right"
}
