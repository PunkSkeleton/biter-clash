
local smallBiterNestItem = table.deepcopy(data.raw["item"]["gun-turret"])
smallBiterNestItem.name = "small-biter-nest"
smallBiterNestItem.icon = "__base__/graphics/icons/biter-spawner.png"
smallBiterNestItem.place_result = "small-biter-nest"

local smallBiterNestRecipe = table.deepcopy(data.raw["recipe"]["gun-turret"])
smallBiterNestRecipe.enabled = false
smallBiterNestRecipe.name = "small-biter-nest"
smallBiterNestRecipe.ingredients = {{"copper-plate",25},{"iron-plate",50}}
smallBiterNestRecipe.result = "small-biter-nest"
smallBiterNestRecipe.energy_required = 30

local smallSpitterNestItem = table.deepcopy(data.raw["item"]["gun-turret"])
smallSpitterNestItem.name = "small-spitter-nest"
smallSpitterNestItem.icon = "__base__/graphics/icons/spitter-spawner.png"
smallSpitterNestItem.place_result = "small-spitter-nest"

local smallSpitterNestRecipe = table.deepcopy(data.raw["recipe"]["gun-turret"])
smallSpitterNestRecipe.enabled = false
smallSpitterNestRecipe.name = "small-spitter-nest"
smallSpitterNestRecipe.ingredients = {{"copper-plate",40},{"iron-plate",25}}
smallSpitterNestRecipe.result = "small-spitter-nest"
smallSpitterNestRecipe.energy_required = 30

local mediumBiterNestItem = table.deepcopy(data.raw["item"]["gun-turret"])
mediumBiterNestItem.name = "medium-biter-nest"
mediumBiterNestItem.icons = {
  {
    icon = "__base__/graphics/icons/biter-spawner.png",
    tint = {r=1.0, g=0.7, b=0.7, a=1.0}
  }}
mediumBiterNestItem.place_result = "medium-biter-nest"

local mediumBiterNestRecipe = table.deepcopy(data.raw["recipe"]["gun-turret"])
mediumBiterNestRecipe.enabled = false
mediumBiterNestRecipe.name = "medium-biter-nest"
mediumBiterNestRecipe.ingredients = {{"electronic-circuit",37},{"steel-plate",75}}
mediumBiterNestRecipe.result = "medium-biter-nest"
mediumBiterNestRecipe.energy_required = 30

local mediumSpitterNestItem = table.deepcopy(data.raw["item"]["gun-turret"])
mediumSpitterNestItem.name = "medium-spitter-nest"
mediumSpitterNestItem.icons = {
  {
    icon = "__base__/graphics/icons/spitter-spawner.png",
    tint = {r=1.0, g=0.7, b=0.7, a=1.0}
  }}
mediumSpitterNestItem.place_result = "medium-spitter-nest"

local mediumSpitterNestRecipe = table.deepcopy(data.raw["recipe"]["gun-turret"])
mediumSpitterNestRecipe.enabled = false
mediumSpitterNestRecipe.name = "medium-spitter-nest"
mediumSpitterNestRecipe.ingredients = {{"electronic-circuit",40},{"steel-plate",35}}
mediumSpitterNestRecipe.result = "medium-spitter-nest"
mediumSpitterNestRecipe.energy_required = 30

local bigBiterNestItem = table.deepcopy(data.raw["item"]["gun-turret"])
bigBiterNestItem.name = "big-biter-nest"
bigBiterNestItem.icons = {
  {
    icon = "__base__/graphics/icons/biter-spawner.png",
    tint = {r=0.13, g=0.56, b=0.66, a=1.0}
  }}
bigBiterNestItem.place_result = "big-biter-nest"

local bigBiterNestRecipe = table.deepcopy(data.raw["recipe"]["gun-turret"])
bigBiterNestRecipe.enabled = false
bigBiterNestRecipe.name = "big-biter-nest"
bigBiterNestRecipe.ingredients = {{"plastic-bar",50},{"engine-unit",50}}
bigBiterNestRecipe.result = "big-biter-nest"
bigBiterNestRecipe.energy_required = 30

local bigSpitterNestItem = table.deepcopy(data.raw["item"]["gun-turret"])
bigSpitterNestItem.name = "big-spitter-nest"
bigSpitterNestItem.icons = {
  {
    icon = "__base__/graphics/icons/spitter-spawner.png",
    tint = {r=0.13, g=0.56, b=0.66, a=1.0}
  }}
bigSpitterNestItem.place_result = "big-spitter-nest"

local bigSpitterNestRecipe = table.deepcopy(data.raw["recipe"]["gun-turret"])
bigSpitterNestRecipe.enabled = false
bigSpitterNestRecipe.name = "big-spitter-nest"
bigSpitterNestRecipe.ingredients = {{"plastic-bar",25},{"engine-unit",25}}
bigSpitterNestRecipe.result = "big-spitter-nest"
bigSpitterNestRecipe.energy_required = 30

local behemothBiterNestItem = table.deepcopy(data.raw["item"]["gun-turret"])
behemothBiterNestItem.name = "behemoth-biter-nest"
behemothBiterNestItem.icons = {
  {
    icon = "__base__/graphics/icons/biter-spawner.png",
    tint = {r=0.3, g=1.0, b=0.1, a=1.0}
  }}
behemothBiterNestItem.place_result = "behemoth-biter-nest"

local behemothBiterNestRecipe = table.deepcopy(data.raw["recipe"]["gun-turret"])
behemothBiterNestRecipe.enabled = false
behemothBiterNestRecipe.name = "behemoth-biter-nest"
behemothBiterNestRecipe.ingredients = {{"advanced-circuit",25},{"flying-robot-frame",25}}
behemothBiterNestRecipe.result = "behemoth-biter-nest"
behemothBiterNestRecipe.energy_required = 30

local behemothSpitterNestItem = table.deepcopy(data.raw["item"]["gun-turret"])
behemothSpitterNestItem.name = "behemoth-spitter-nest"
behemothSpitterNestItem.icons = {
  {
    icon = "__base__/graphics/icons/spitter-spawner.png",
    tint = {r=0.3, g=1.0, b=0.1, a=1.0}
  }}
behemothSpitterNestItem.place_result = "behemoth-spitter-nest"

local behemothSpitterNestRecipe = table.deepcopy(data.raw["recipe"]["gun-turret"])
behemothSpitterNestRecipe.enabled = false
behemothSpitterNestRecipe.name = "behemoth-spitter-nest"
behemothSpitterNestRecipe.ingredients = {{"advanced-circuit",13},{"flying-robot-frame",13}}
behemothSpitterNestRecipe.result = "behemoth-spitter-nest"
behemothSpitterNestRecipe.energy_required = 30

data:extend{smallBiterNestRecipe, smallBiterNestItem, smallSpitterNestRecipe, smallSpitterNestItem, mediumBiterNestRecipe, mediumBiterNestItem, mediumSpitterNestRecipe, mediumSpitterNestItem}
data:extend{bigBiterNestRecipe, bigBiterNestItem, bigSpitterNestRecipe, bigSpitterNestItem, behemothBiterNestRecipe, behemothBiterNestItem, behemothSpitterNestRecipe, behemothSpitterNestItem}