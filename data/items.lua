local rocketSilo = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"]) 
rocketSilo.rocket_parts_required = 10
rocketSilo.energy_usage = "10kW"
rocketSilo.idle_energy_usage = "1W"
rocketSilo.active_energy_usage = "20kW"
rocketSilo.is_military_target = true
  
data:extend{rocketSilo}