storage["northSiloId"] = 0
storage["southSiloId"] = 0
storage["surfaceIndex"] = 0
storage["surfaceName"] = "biterWars" .. storage["surfaceIndex"]
storage["prepareMap"] = true
storage["biterAreaToBeCleared"] = true
storage["mapToBeCloned"] = true
storage["mapToBeCloned2"] = true
storage["gameStarted"] = false
storage["mapGeneratedTick"] = 0
storage["gameStartedTick"] = 0
storage["newSurfaceIndex"] = 0
storage["newSurfaceName"] = "biterWars" .. storage["newSurfaceIndex"]
storage["biterStagingAreaPointer"] = 0
storage["adrenalineResearchedNorth"] = false
storage["adrenalineResearchedSouth"] = false
storage["alcoholResearchedNorth"] = false
storage["alcoholResearchedSouth"] = false
storage["resistanceResearchedNorth"] = false
storage["resistanceResearchedSouth"] = false
storage["heavySpitResearchedNorth"] = false
storage["heavySpitResearchedSouth"] = false
storage["sharpTeethResearchedNorth"] = false
storage["sharpTeethResearchedSouth"] = false
storage["artilleryResearchedNorth"] = false
storage["artilleryResearchedSouth"] = false
storage["regenerationResearchedNorth"] = false
storage["regenerationResearchedSouth"] = false
storage["aoeResearchedNorth"] = false
storage["aoeResearchedSouth"] = false
storage["activeBiterGroups"] = {}
storage["aiRootActive"] = false
storage["aiStep"] = 1
storage["northAiBiters"] = nil
storage["southAiBiters"] = nil
storage["northAiBiterGroup"] = nil
storage["southAiBiterGroup"] = nil
storage["northSideReady"] = false
storage["southSideReady"] = false
storage["countdown"] = 11
storage["lockTeams"] = false
storage["northResearchedString"] = "North completed research:\n"
storage["southResearchedString"] = "South completed research:\n"
storage["insightsItems"] = {"firearm-magazine", "piercing-rounds-magazine",
							"gun-turret", "flamethrower-turret", "laser-turret", 
							"stone-wall", "grenade", "poison-capsule", "slowdown-capsule",
							"automation-science-pack", "logistic-science-pack", "military-science-pack", "chemical-science-pack", "production-science-pack", "utility-science-pack",
							"small-biter-nest", "medium-biter-nest", "big-biter-nest", "behemoth-biter-nest",
							"small-spitter-nest", "medium-spitter-nest", "big-spitter-nest", "behemoth-spitter-nest"
							}
storage["insightsNonKillableItems"] = {"firearm-magazine", "piercing-rounds-magazine",
						    "grenade", "poison-capsule", "slowdown-capsule",
							"automation-science-pack", "logistic-science-pack", "military-science-pack", "chemical-science-pack", "production-science-pack", "utility-science-pack"
							}
storage["insightsKillableItems"] = {"gun-turret", "flamethrower-turret", "laser-turret", "stone-wall", 
							"small-biter-nest", "medium-biter-nest", "big-biter-nest", "behemoth-biter-nest",
							"small-spitter-nest", "medium-spitter-nest", "big-spitter-nest", "behemoth-spitter-nest"
							}