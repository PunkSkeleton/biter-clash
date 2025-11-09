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
storage["biterGroupsUpdateList"] = {}
storage["biterGroupsUpdateListFinished"] = true
storage["biterGroupsUpdateListPointer"] = 1
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
storage["singlePlayer"] = false
storage["difficulty"] = 20
storage["aiIncome"] = 0
storage["aiMoney"] = 0
storage["weaponSpeedResearch"] = {"weapon-shooting-speed-1", "weapon-shooting-speed-2", "weapon-shooting-speed-3", "weapon-shooting-speed-4", "weapon-shooting-speed-5", "weapon-shooting-speed-6", "weapon-shooting-speed-7"}
storage["weaponSpeedResearchPointer"] = 1
storage["weaponDamageResearch"] = {"physical-projectile-damage-1", "physical-projectile-damage-2", "physical-projectile-damage-3", "physical-projectile-damage-4", "physical-projectile-damage-5", "physical-projectile-damage-6", "physical-projectile-damage-7"}
storage["weaponDamageResearchPointer"] = 1
storage["biterResearch"] = {"small-biter", "adrenaline", "medium-biter", "resistance", "big-biter", "sharp-teeth", "behemoth-biter", "rapid-regeneration"}
storage["biterResearchPointer"] = 1
storage["spitterResearch"] = {"small-spitter", "alcohol", "medium-spitter", "heavy-spit", "big-spitter", "artillery-spitter", "behemoth-spitter", "aoe-spitter"}
storage["spitterResearchPointer"] = 1
storage["currentBiterNest"] = ""
storage["currentSpitterNest"] = ""
storage["bitersResearched"] = false
storage["spittersResearched"] = false
storage["aiSpendingTarget"] = ""
storage["aiSpendingCost"] = 0
storage["aiMaxRandom"] = 39
storage["currentSpitterNest"] = ""
storage["currentBiterNest"] = ""
storage["researchingBiters"] = false
storage["researchingSpitters"] = false
storage["biterNestMap"] = {"small-biter-nest", "nest-adrenaline", "medium-biter-nest", "nest-resistant", "big-biter-nest", "big-biter-nest-sharp-teeth", "behemoth-biter-nest", "behemoth-biter-nest-regen"}
storage["spitterNestMap"] = {"small-spitter-nest", "nest-drunken", "medium-spitter-nest", "medium-spitter-nest-heavy", "big-spitter-nest", "artillery-spitter-nest", "behemoth-spitter-nest", "behemoth-spitter-nest-aoe"}
storage["stagingAreaNumber"] = ""
storage["changeStagingArea"] = true