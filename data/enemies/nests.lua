cooldown = 1800

local smallBiterNest = table.deepcopy(data.raw["unit-spawner"]["biter-spawner"])
smallBiterNest.name = "small-biter-nest"
smallBiterNest.flags = {"placeable-player", "player-creation", "placeable-enemy", "not-repairable"}
smallBiterNest.max_health = 999999
smallBiterNest.healing_per_tick = 1
smallBiterNest.max_count_of_owned_units = 99999
smallBiterNest.max_friends_around_to_spawn = 99999
smallBiterNest.max_richness_for_spawn_shift = 99999
smallBiterNest.max_spawn_shift = 1
smallBiterNest.result_units = (function()
                     local res = {}
                     res[1] = {"small-biter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()
smallBiterNest.spawning_cooldown = {cooldown, cooldown}

local smallBiterNestAdrenaline = table.deepcopy(smallBiterNest)
smallBiterNestAdrenaline.name = "nest-adrenaline"
smallBiterNestAdrenaline.tint = {r=0.9, g=0.9, b=0.9, a=1.0}
smallBiterNestAdrenaline.result_units = (function()
                     local res = {}
                     res[1] = {"adrenaline-small-biter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

local smallSpitterNest = table.deepcopy(data.raw["unit-spawner"]["spitter-spawner"])
smallSpitterNest.name = "small-spitter-nest"
smallSpitterNest.flags = {"placeable-player", "player-creation", "placeable-enemy", "not-repairable"}
smallSpitterNest.max_health = 999999
smallSpitterNest.healing_per_tick = 1
smallSpitterNest.max_count_of_owned_units = 9999
smallSpitterNest.max_friends_around_to_spawn = 9999
smallSpitterNest.max_richness_for_spawn_shift = 9999
smallSpitterNest.result_units = (function()
                     local res = {}
                     res[1] = {"small-spitter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()
smallSpitterNest.spawning_cooldown = {cooldown, cooldown}

local smallSpitterNestDrunken = table.deepcopy(smallSpitterNest)
smallSpitterNestDrunken.name = "nest-drunken"
smallBiterNestAdrenaline.tint = {r=0.9, g=0.9, b=0.9, a=1.0}
smallSpitterNestDrunken.result_units = (function()
                     local res = {}
                     res[1] = {"small-spitter", {{0.0, 0.5}, {1.0, 0.5}}}
                     res[2] = {"drunken-small-spitter", {{0.0, 0.5}, {1.0, 0.5}}}
                     return res
                   end)()

local mediumBiterNest = table.deepcopy(smallBiterNest)
mediumBiterNest.name = "medium-biter-nest"
mediumBiterNest.tint = {r=1.0, g=0.7, b=0.7, a=1.0}
mediumBiterNest.result_units = (function()
                     local res = {}
                     res[1] = {"medium-biter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

local mediumBiterNestResistant = table.deepcopy(smallBiterNest)
mediumBiterNestResistant.name = "nest-resistant"
mediumBiterNestResistant.tint = {r=0.9, g=0.6, b=0.6, a=1.0}
mediumBiterNestResistant.result_units = (function()
                     local res = {}
                     res[1] = {"resistant-medium-biter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

local mediumSpitterNest = table.deepcopy(smallSpitterNest)
mediumSpitterNest.name = "medium-spitter-nest"
mediumSpitterNest.tint = {r=1.0, g=0.7, b=0.7, a=1.0}
mediumSpitterNest.result_units = (function()
                     local res = {}
                     res[1] = {"medium-spitter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

local mediumSpitterHeavyNest = table.deepcopy(smallSpitterNest)
mediumSpitterHeavyNest.name = "medium-spitter-nest-heavy"
mediumSpitterHeavyNest.tint = {r=0.9, g=0.6, b=0.6, a=1.0}
mediumSpitterHeavyNest.result_units = (function()
                     local res = {}
                     res[1] = {"heavy-hitter-medium-spitter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

local bigBiterNestSharpTeeth = table.deepcopy(smallBiterNest)
bigBiterNestSharpTeeth.name = "big-biter-nest-sharp-teeth"
bigBiterNestSharpTeeth.tint = {r=0.03, g=0.46, b=0.56, a=1.0}
bigBiterNestSharpTeeth.result_units = (function()
                     local res = {}
                     res[1] = {"sharp-teeth-big-biter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

local bigBiterNest = table.deepcopy(smallBiterNest)
bigBiterNest.name = "big-biter-nest"
bigBiterNest.tint = {r=0.13, g=0.56, b=0.66, a=1.0}
bigBiterNest.result_units = (function()
                     local res = {}
                     res[1] = {"big-biter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

local bigSpitterNest = table.deepcopy(smallSpitterNest)
bigSpitterNest.name = "big-spitter-nest"
bigSpitterNest.tint = {r=0.13, g=0.56, b=0.66, a=1.0}
bigSpitterNest.result_units = (function()
                     local res = {}
                     res[1] = {"big-spitter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

local artillerySpitterNest = table.deepcopy(smallSpitterNest)
artillerySpitterNest.name = "artillery-spitter-nest"
artillerySpitterNest.tint = {r=0.03, g=0.46, b=0.56, a=1.0}
artillerySpitterNest.result_units = (function()
                     local res = {}
                     res[1] = {"artillery-big-spitter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

local behemothBiterNest = table.deepcopy(smallBiterNest)
behemothBiterNest.name = "behemoth-biter-nest"
behemothBiterNest.tint = {r=0.3, g=1.0, b=0.1, a=1.0}
behemothBiterNest.result_units = (function()
                     local res = {}
                     res[1] = {"behemoth-biter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

local behemothBiterNestRegen = table.deepcopy(smallBiterNest)
behemothBiterNestRegen.name = "behemoth-biter-nest-regen"
behemothBiterNestRegen.tint = {r=0.2, g=0.9, b=0, a=1.0}
behemothBiterNestRegen.result_units = (function()
                     local res = {}
                     res[1] = {"regenerative-behemoth-biter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

local behemothSpitterNest = table.deepcopy(smallSpitterNest)
behemothSpitterNest.name = "behemoth-spitter-nest"
behemothSpitterNest.tint = {r=0.3, g=1.0, b=0.1, a=1.0}
behemothSpitterNest.result_units = (function()
                     local res = {}
                     res[1] = {"behemoth-spitter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

local behemothSpitterNestAoE = table.deepcopy(smallSpitterNest)
behemothSpitterNestAoE.name = "behemoth-spitter-nest-aoe"
behemothSpitterNestAoE.tint = {r=0.2, g=0.9, b=0, a=1.0}
behemothSpitterNestAoE.result_units = (function()
                     local res = {}
                     res[1] = {"aoe-behemoth-spitter", {{0.0, 1.0}, {1.0, 1.0}}}
                     return res
                   end)()

data:extend{smallBiterNestAdrenaline, smallBiterNest, smallSpitterNestDrunken, smallSpitterNest, mediumBiterNestResistant, mediumBiterNest, mediumSpitterNest, mediumSpitterHeavyNest}
data:extend{bigBiterNestSharpTeeth, bigBiterNest, artillerySpitterNest, bigSpitterNest, behemothBiterNestRegen, behemothBiterNest, behemothSpitterNest, behemothSpitterNestAoE}
