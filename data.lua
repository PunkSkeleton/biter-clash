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
