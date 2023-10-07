global["northSiloId"] = 0
global["southSiloId"] = 0
global["surfaceIndex"] = 0
global["surfaceName"] = "biterWars" .. global["surfaceIndex"]
global["prepareMap"] = true
global["biterAreaToBeCleared"] = true
global["mapToBeCloned"] = true
global["mapToBeCloned2"] = true
global["gameStarted"] = false
global["mapGeneratedTick"] = 0
global["gameStartedTick"] = 0
global["newSurfaceIndex"] = 0
global["newSurfaceName"] = "biterWars" .. global["newSurfaceIndex"]
global["biterStagingAreaPointer"] = 0
global["adrenalineResearchedNorth"] = false
global["adrenalineResearchedSouth"] = false
global["alcoholResearchedNorth"] = false
global["alcoholResearchedSouth"] = false
global["resistanceResearchedNorth"] = false
global["resistanceResearchedSouth"] = false
global["heavySpitResearchedNorth"] = false
global["heavySpitResearchedSouth"] = false
global["sharpTeethResearchedNorth"] = false
global["sharpTeethResearchedSouth"] = false
global["artilleryResearchedNorth"] = false
global["artilleryResearchedSouth"] = false
global["regenerationResearchedNorth"] = false
global["regenerationResearchedSouth"] = false
global["aoeResearchedNorth"] = false
global["aoeResearchedSouth"] = false
global["activeBiterGroups"] = {}
global["aiRootActive"] = false
global["aiStep"] = 1
global["northAiBiters"] = nil
global["southAiBiters"] = nil
global["northAiBiterGroup"] = nil
global["southAiBiterGroup"] = nil
global["northSideReady"] = false
global["southSideReady"] = false
global["countdown"] = 11
global["lockTeams"] = false
global["northResearchedString"] = "North completed research:\n"
global["southResearchedString"] = "South completed research:\n"
global["insightsItems"] = {"firearm-magazine", "piercing-rounds-magazine",
							"gun-turret", "flamethrower-turret", "laser-turret", 
							"stone-wall", "grenade", "poison-capsule", "slowdown-capsule",
							"automation-science-pack", "logistic-science-pack", "military-science-pack", "chemical-science-pack", "production-science-pack", "utility-science-pack",
							"small-biter-nest", "medium-biter-nest", "big-biter-nest", "behemoth-biter-nest",
							"small-spitter-nest", "medium-spitter-nest", "big-spitter-nest", "behemoth-spitter-nest"
							}
global["insightsNonKillableItems"] = {"firearm-magazine", "piercing-rounds-magazine",
						    "grenade", "poison-capsule", "slowdown-capsule",
							"automation-science-pack", "logistic-science-pack", "military-science-pack", "chemical-science-pack", "production-science-pack", "utility-science-pack"
							}
global["insightsKillableItems"] = {"gun-turret", "flamethrower-turret", "laser-turret", "stone-wall", 
							"small-biter-nest", "medium-biter-nest", "big-biter-nest", "behemoth-biter-nest",
							"small-spitter-nest", "medium-spitter-nest", "big-spitter-nest", "behemoth-spitter-nest"
							}