
local smallBiterNestItem = table.deepcopy(data.raw["item"]["gun-turret"])
smallBiterNestItem.name = "small-biter-nest"
smallBiterNestItem.icon = "__base__/graphics/icons/biter-spawner.png"
smallBiterNestItem.place_result = "small-biter-nest"

local smallBiterNestRecipe = table.deepcopy(data.raw["recipe"]["gun-turret"])
smallBiterNestRecipe.enabled = false
smallBiterNestRecipe.name = "small-biter-nest"
smallBiterNestRecipe.ingredients = {
    {type = "item", name = "copper-plate", amount = 90},
    {type = "item", name = "iron-plate", amount = 180}
  }
smallBiterNestRecipe.results = {{type = "item", name = "small-biter-nest", amount = 1}}
smallBiterNestRecipe.energy_required = 60

local smallSpitterNestItem = table.deepcopy(data.raw["item"]["gun-turret"])
smallSpitterNestItem.name = "small-spitter-nest"
smallSpitterNestItem.icon = "__base__/graphics/icons/spitter-spawner.png"
smallSpitterNestItem.place_result = "small-spitter-nest"

local smallSpitterNestRecipe = table.deepcopy(data.raw["recipe"]["gun-turret"])
smallSpitterNestRecipe.enabled = false
smallSpitterNestRecipe.name = "small-spitter-nest"
smallSpitterNestRecipe.ingredients = {
    {type = "item", name = "copper-plate", amount = 160},
    {type = "item", name = "iron-plate", amount = 80}
  }
smallSpitterNestRecipe.results = {{type = "item", name = "small-spitter-nest", amount = 1}}
smallSpitterNestRecipe.energy_required = 60

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
mediumBiterNestRecipe.ingredients = {
    {type = "item", name = "electronic-circuit", amount = 75},
    {type = "item", name = "steel-plate", amount = 150}
  }
mediumBiterNestRecipe.results = {{type = "item", name = "medium-biter-nest", amount = 1}}
mediumBiterNestRecipe.energy_required = 60

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
mediumSpitterNestRecipe.ingredients = {
    {type = "item", name = "electronic-circuit", amount = 80},
    {type = "item", name = "steel-plate", amount = 70}
  }
mediumSpitterNestRecipe.results = {{type = "item", name = "medium-spitter-nest", amount = 1}}
mediumSpitterNestRecipe.energy_required = 60

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
bigBiterNestRecipe.ingredients = {
    {type = "item", name = "plastic-bar", amount = 100},
    {type = "item", name = "engine-unit", amount = 100}
  }
bigBiterNestRecipe.results = {{type = "item", name = "big-biter-nest", amount = 1}}
bigBiterNestRecipe.energy_required = 60

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
bigSpitterNestRecipe.ingredients = {
    {type = "item", name = "plastic-bar", amount = 50},
    {type = "item", name = "engine-unit", amount = 50}
  }
bigSpitterNestRecipe.results = {{type = "item", name = "big-spitter-nest", amount = 1}}
bigSpitterNestRecipe.energy_required = 60

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
behemothBiterNestRecipe.ingredients = {
    {type = "item", name = "advanced-circuit", amount = 50},
    {type = "item", name = "flying-robot-frame", amount = 50}
  }
behemothBiterNestRecipe.results = {{type = "item", name = "behemoth-biter-nest", amount = 1}}
behemothBiterNestRecipe.energy_required = 60

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
behemothSpitterNestRecipe.ingredients = {
    {type = "item", name = "advanced-circuit", amount = 25},
    {type = "item", name = "flying-robot-frame", amount = 25}
  }
behemothSpitterNestRecipe.results = {{type = "item", name = "behemoth-spitter-nest", amount = 1}}
behemothSpitterNestRecipe.energy_required = 60

data:extend{smallBiterNestRecipe, smallBiterNestItem, smallSpitterNestRecipe, smallSpitterNestItem, mediumBiterNestRecipe, mediumBiterNestItem, mediumSpitterNestRecipe, mediumSpitterNestItem}
data:extend{bigBiterNestRecipe, bigBiterNestItem, bigSpitterNestRecipe, bigSpitterNestItem, behemothBiterNestRecipe, behemothBiterNestItem, behemothSpitterNestRecipe, behemothSpitterNestItem}