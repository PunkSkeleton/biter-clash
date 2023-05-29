function onResearchFinished(event)
	game.forces["spectators"].print("Team " .. event.research.force.name .. " finished researching " .. event.research.name .. "!")
	if event.research.name == "adrenaline" then
		if event.research.force.name == "north" then
			global["adrenalineResearchedNorth"] = true
			swapBuiltNest("small-biter-nest", "nest-adrenaline", "north")
		else 
			global["adrenalineResearchedSouth"] = true
			swapBuiltNest("small-biter-nest", "nest-adrenaline", "south")
		end
	end
	if event.research.name == "alcohol" then
		if event.research.force.name == "north" then
			global["alcoholResearchedNorth"] = true
			swapBuiltNest("small-spitter-nest", "nest-drunken", "north")
		else 
			global["alcoholResearchedSouth"] = true
			swapBuiltNest("small-spitter-nest", "nest-drunken", "south")
		end
	end
	if event.research.name == "resistance" then
		if event.research.force.name == "north" then
			global["resistanceResearchedNorth"] = true
			swapBuiltNest("medium-biter-nest", "nest-resistant", "north")
		else 
			global["resistanceResearchedSouth"] = true
			swapBuiltNest("medium-biter-nest", "nest-resistant", "south")
		end
	end
	if event.research.name == "heavy-spit" then
		if event.research.force.name == "north" then
			global["heavySpitResearchedNorth"] = true
			swapBuiltNest("medium-spitter-nest", "medium-spitter-nest-heavy", "north")
		else 
			global["heavySpitResearchedSouth"] = true
			swapBuiltNest("medium-spitter-nest", "medium-spitter-nest-heavy", "south")
		end
	end
	if event.research.name == "sharp-teeth" then
		if event.research.force.name == "north" then
			global["sharpTeethResearchedNorth"] = true
			swapBuiltNest("big-biter-nest", "big-biter-nest-sharp-teeth", "north")
		else 
			global["sharpTeethResearchedSouth"] = true
			swapBuiltNest("big-biter-nest", "big-biter-nest-sharp-teeth", "south")
		end
	end
	if event.research.name == "artillery-spitter" then
		if event.research.force.name == "north" then
			global["artilleryResearchedNorth"] = true
			swapBuiltNest("big-spitter-nest", "artillery-spitter-nest", "north")
		else 
			global["artilleryResearchedSouth"] = true
			swapBuiltNest("big-spitter-nest", "artillery-spitter-nest", "south")
		end
	end
	if event.research.name == "rapid-regeneration" then
		if event.research.force.name == "north" then
			global["regenerationResearchedNorth"] = true
			swapBuiltNest("behemoth-biter-nest", "behemoth-biter-nest-regen", "north")
		else 
			global["regenerationResearchedSouth"] = true
			swapBuiltNest("behemoth-biter-nest", "behemoth-biter-nest-regen", "south")
		end
	end
	if event.research.name == "aoe-spitter" then
		if event.research.force.name == "north" then
			global["aoeResearchedNorth"] = true
			swapBuiltNest("behemoth-spitter-nest", "behemoth-spitter-nest-aoe", "north")
		else 
			global["aoeResearchedSouth"] = true
			swapBuiltNest("behemoth-spitter-nest", "behemoth-spitter-nest-aoe", "south")
		end
	end
end

function onResearchStarted(event)
	game.forces["spectators"].print("Team " .. event.research.force.name .. " started researching " .. event.research.name .. "!")
end

function onBuiltEntity(event)
	if global["gameStarted"] then
		local entity = event.created_entity	
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
	if event.registration_number == global["northSiloId"] then
		gameOver("south")
	elseif event.registration_number == global["southSiloId"] then
		gameOver("north")
	end
end

function onPlayerRespawned(event)
	player = game.get_player(event.player_index)
	if player.force == "north" then
		pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0,-740}, 5, 0.1)
	elseif player.force == "south" then
		pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0, 760}, 5, 0.1)
	end
	--player.teleport(pos, global["surfaceName"])	
end

function onPlayerDied(event)
	player = game.get_player(event.player_index)
	player.ticks_to_respawn = math.ceil((event.tick - global["gameStartedTick"]) / 60)
end

function onRocketLaunched(event) 
	if event.rocket_silo.force.name == "south" then
		gameOver("south")
	elseif event.rocket_silo.force.name == "north" then
		gameOver("north")
	end
end

