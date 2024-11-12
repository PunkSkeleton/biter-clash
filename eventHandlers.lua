function onResearchFinished(event)
	game.forces["spectators"].print("Team " .. event.research.force.name .. " finished researching " .. event.research.name .. "!")
	if event.research.force.name == "north" then
		storage["northResearchedString"] = storage["northResearchedString"] .. calculateTime() .. ": " .. event.research.name .. "\n"
	else
		storage["southResearchedString"] = storage["southResearchedString"] .. calculateTime() .. ": " .. event.research.name .. "\n"
	end
	if event.research.name == "adrenaline" then
		if event.research.force.name == "north" then
			storage["adrenalineResearchedNorth"] = true
			swapBuiltNest("small-biter-nest", "nest-adrenaline", "north")
		else 
			storage["adrenalineResearchedSouth"] = true
			swapBuiltNest("small-biter-nest", "nest-adrenaline", "south")
		end
	end
	if event.research.name == "alcohol" then
		if event.research.force.name == "north" then
			storage["alcoholResearchedNorth"] = true
			swapBuiltNest("small-spitter-nest", "nest-drunken", "north")
		else 
			storage["alcoholResearchedSouth"] = true
			swapBuiltNest("small-spitter-nest", "nest-drunken", "south")
		end
	end
	if event.research.name == "resistance" then
		if event.research.force.name == "north" then
			storage["resistanceResearchedNorth"] = true
			swapBuiltNest("medium-biter-nest", "nest-resistant", "north")
		else 
			storage["resistanceResearchedSouth"] = true
			swapBuiltNest("medium-biter-nest", "nest-resistant", "south")
		end
	end
	if event.research.name == "heavy-spit" then
		if event.research.force.name == "north" then
			storage["heavySpitResearchedNorth"] = true
			swapBuiltNest("medium-spitter-nest", "medium-spitter-nest-heavy", "north")
		else 
			storage["heavySpitResearchedSouth"] = true
			swapBuiltNest("medium-spitter-nest", "medium-spitter-nest-heavy", "south")
		end
	end
	if event.research.name == "sharp-teeth" then
		if event.research.force.name == "north" then
			storage["sharpTeethResearchedNorth"] = true
			swapBuiltNest("big-biter-nest", "big-biter-nest-sharp-teeth", "north")
		else 
			storage["sharpTeethResearchedSouth"] = true
			swapBuiltNest("big-biter-nest", "big-biter-nest-sharp-teeth", "south")
		end
	end
	if event.research.name == "artillery-spitter" then
		if event.research.force.name == "north" then
			storage["artilleryResearchedNorth"] = true
			swapBuiltNest("big-spitter-nest", "artillery-spitter-nest", "north")
		else 
			storage["artilleryResearchedSouth"] = true
			swapBuiltNest("big-spitter-nest", "artillery-spitter-nest", "south")
		end
	end
	if event.research.name == "rapid-regeneration" then
		if event.research.force.name == "north" then
			storage["regenerationResearchedNorth"] = true
			swapBuiltNest("behemoth-biter-nest", "behemoth-biter-nest-regen", "north")
		else 
			storage["regenerationResearchedSouth"] = true
			swapBuiltNest("behemoth-biter-nest", "behemoth-biter-nest-regen", "south")
		end
	end
	if event.research.name == "aoe-spitter" then
		if event.research.force.name == "north" then
			storage["aoeResearchedNorth"] = true
			swapBuiltNest("behemoth-spitter-nest", "behemoth-spitter-nest-aoe", "north")
		else 
			storage["aoeResearchedSouth"] = true
			swapBuiltNest("behemoth-spitter-nest", "behemoth-spitter-nest-aoe", "south")
		end
	end
end

function onResearchStarted(event)
	game.forces["spectators"].print("Team " .. event.research.force.name .. " started researching " .. event.research.name .. "!")
end

function onBuiltEntity(event)
	if storage["gameStarted"] then
		local entity = event.entity	
		if entity.is_registered_for_construction() then
			if entity.ghost_prototype.type == "unit-spawner"	 then
				local player = game.players[event.player_index]
				if playerHasItem(player, entity.ghost_name) then
					local force = player.force.name
					if force == "north" then
						if positionInsideSpawnerArea(750, entity.position) then
							ghostName = entity.ghost_name
							if swapNests(entity, "north") then
								removeFromInventory(player, ghostName)
							end			
						end
					elseif force == "south" then
						if positionInsideSpawnerArea(-750, entity.position) then
							ghostName = entity.ghost_name
							if swapNests(entity, "south") then
								removeFromInventory(player, ghostName)
							end
						end
					end					
				end		
			end
		elseif entity.type == "unit-spawner" then
			local player = game.players[event.player_index]
			entityName = entity.name
			entity.destroy()
			addToInventory(player,entityName)
			player.print("Please place nests as ghosts on the revealed area around enemy base, on the outside of the black line!")
		end
	end
end

function onEntityDestroyed(event) 
	if event.registration_number == storage["northSiloId"] then
		gameOver("south")
	elseif event.registration_number == storage["southSiloId"] then
		gameOver("north")
	end
end

function onPlayerRespawned(event)
	player = game.get_player(event.player_index)
	clearInventory(player)
end

function onPlayerDied(event)
	player = game.get_player(event.player_index)
	player.ticks_to_respawn = math.ceil((event.tick - storage["gameStartedTick"]) / 120)
end

function onRocketLaunched(event) 
	if event.rocket_silo.force.name == "south" then
		gameOver("south")
	elseif event.rocket_silo.force.name == "north" then
		gameOver("north")
	end
end

