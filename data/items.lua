local rocketSilo = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"]) 
rocketSilo.rocket_parts_required = 10
rocketSilo.energy_usage = "10kW"
rocketSilo.idle_energy_usage = "1W"
rocketSilo.active_energy_usage = "20kW"
rocketSilo.is_military_target = true
rocketSilo.minable = {mining_time = 5, result = "rocket-silo"}

local resourceChest = table.deepcopy(data.raw["container"]["steel-chest"]) 
resourceChest.name = "resource-chest"
resourceChest.minable = {mining_time = 5, result = "steel-chest"}
resourceChest.tint = {r=0.6, g=0.6, b=0.6, a=1.0}
resourceChest.max_health = 500

local freeWaterPump = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"]) 
freeWaterPump.name = "free-water-pump"
freeWaterPump.minable = {mining_time = 5, result = "offshore-pump"}
freeWaterPump.tint = {r=0.6, g=0.6, b=0.6, a=1.0}
freeWaterPump.max_health = 500
  
data:extend{rocketSilo, resourceChest, freeWaterPump}