function startswith(text, prefix)
    return text:find(prefix, 1, true) == 1
end

function clearArea(x1,x2,y1,y2, includeCharacter)
	for _, entity in pairs(game.surfaces[global["surfaceName"]].find_entities({{x1, y1}, {x2, y2}})) do
		if (entity.name~="character") or includeCharacter then
			entity.destroy()
		end
	end
	game.surfaces[global["surfaceName"]].destroy_decoratives{area={{x1,y1},{x2,y2}}}
end

function chartSpawningArea(offset, forceName)
	game.forces[forceName].chart(global["surfaceName"],{{-550,-550+offset}, {-500,550+offset}})
	game.forces[forceName].chart(global["surfaceName"],{{-550,-550+offset}, {550,-500+offset}})
	game.forces[forceName].chart(global["surfaceName"],{{500,-550+offset}, {550,550+offset}})
	game.forces[forceName].chart(global["surfaceName"],{{-550,500+offset}, {550,550+offset}})
end

function convertBlueprints(offset, forceName, packchest)
	if packchest.valid then
		for _, entity in pairs(game.surfaces[global["surfaceName"]].find_entities({{-50, offset-50}, {50, offset+50}})) do
			remainingGhost = true
			if entity.is_registered_for_construction() then
				for item_name, item_count  in pairs (packchest.get_inventory(defines.inventory.chest).get_contents()) do
					if item_name == entity.ghost_name then 
				    	if item_count > 0 then
				    		entity.revive()
				    		packchest.get_inventory(defines.inventory.chest).remove({name=item_name, count=1})
				    		remainingGhost = false
				    		break
				    	end
				    end
				end
				if remainingGhost then
					entity.destroy()
				end
			end
		end
	end
end

function clearAllGhosts()
	for _, entity in pairs(game.surfaces[global["surfaceName"]].find_entities({{-1000, -2000}, {1000, 2000}})) do
		if entity.is_registered_for_construction() then
			entity.destroy()
		end
	end
end

function removeAllBluprints()
	for _, player in pairs(game.connected_players) do
		for item_name, item_count  in pairs (player.get_inventory(defines.inventory.character_main).get_contents()) do
			if item_name == "blueprint" or item_name == "blueprint-book" or item_name == "deconstruction-planner" or item_name == "upgrade-planner" then
				player.get_inventory(defines.inventory.character_main).remove({name=item_name, count=1})
			end		
		end
		local cursor_stack = player.cursor_stack 
		if cursor_stack ~= nil then
			if cursor_stack.valid_for_read == true then
				local item_name = cursor_stack.name
				if item_name == "blueprint" or item_name == "blueprint-book" or item_name == "deconstruction-planner" or item_name == "upgrade-planner" then
					cursor_stack.count = 0
				end
			end
		end
	end 
end

function clearInventory(player)
	for item_name, item_count  in pairs (player.get_inventory(defines.inventory.character_main).get_contents()) do
		player.get_inventory(defines.inventory.character_main).remove({name=item_name, count=item_count})
	end
	player.get_inventory(defines.inventory.character_guns).clear()
	player.get_inventory(defines.inventory.character_ammo).clear()
	player.get_inventory(defines.inventory.character_armor).clear()
	player.get_inventory(defines.inventory.character_trash).clear()
	local cursor_stack = player.cursor_stack 
	if cursor_stack ~= nil then
		if cursor_stack.valid_for_read == true then
			local item_name = cursor_stack.name
			cursor_stack.count = 0
		end
	end
end

function clearInventories()
	for _, player in pairs(game.connected_players) do
		cancelCrafting(player)
		clearInventory(player)
	end 
end

function clearQuickBars()
	for _, player in pairs(game.connected_players) do
		for i=1,100,1 do
			player.set_quick_bar_slot(i, nil)
		end
	end
end

function playerHasItem(player, item)
	local cursor_stack = player.cursor_stack 
	if cursor_stack ~= nil then
		if cursor_stack.valid_for_read == true then
			if cursor_stack.name == item then
				return true
			end
		end
	end
	for item_name, item_count  in pairs (player.get_inventory(defines.inventory.character_main).get_contents()) do
		if item_name == item then
			return true
		end		
	end
	return false
end

function removeFromInventory(player, item)
	local cursor_stack = player.cursor_stack 
	if cursor_stack ~= nil then
		if cursor_stack.valid_for_read == true then
			if cursor_stack.name == item then
				cursor_stack.count = cursor_stack.count - 1
				return
			end
		end
	end
	for item_name, item_count  in pairs (player.get_inventory(defines.inventory.character_main).get_contents()) do
		if item_name == item then
			player.get_inventory(defines.inventory.character_main).remove({name=item_name, count=1})
			return
		end		
	end
end

function addToInventory(player, item)
	player.get_inventory(defines.inventory.character_main).insert({name=item, count=1}) 	
end

function positionInsideSpawnerArea(offset, position)
	if positionInsideArea(position, -550,-550+offset, -500,550+offset) then
		return true
	end
	if positionInsideArea(position, -550,-550+offset, 550,-500+offset) then
		return true
	end
	if positionInsideArea(position, 500,-550+offset, 550,550+offset) then
		return true
	end
	if positionInsideArea(position, -550,500+offset, 550,550+offset) then
		return true
	end
	return false
end

function positionInsideArea(position, x1, y1, x2, y2)
	if position.x > x1 and position.x < x2 and position.y > y1 and position.y < y2 then
		return true
	else
		return false
	end
end

function itemNotNil(item)
	if item == nil then
		return false
	else
		return true
	end
end

function simpleRevive(entity)
	a,b,c = entity.revive()
	if b == nil then
		return false
	else
		return true
	end
end

function swapNests(entity, force)
	if (entity.ghost_name == "small-biter-nest") then
		if force == "north" then
			if global["adrenalineResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "nest-adrenaline", position = pos, force =  "north"}))					
			else
				return simpleRevive(entity)
			end
		else
			if global["adrenalineResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "nest-adrenaline", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "small-spitter-nest") then
		if force == "north" then
			if global["alcoholResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "nest-drunken", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if global["alcoholResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "nest-drunken", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "medium-biter-nest") then
		if force == "north" then
			if global["resistanceResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "nest-resistant", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if global["resistanceResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "nest-resistant", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "medium-spitter-nest") then
		if force == "north" then
			if global["heavySpitResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "medium-spitter-nest-heavy", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if global["heavySpitResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "medium-spitter-nest-heavy", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "big-biter-nest") then
		if force == "north" then
			if global["sharpTeethResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "big-biter-nest-sharp-teeth", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if global["sharpTeethResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "big-biter-nest-sharp-teeth", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "big-spitter-nest") then
		if force == "north" then
			if global["artilleryResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "artillery-spitter-nest", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if global["artilleryResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "artillery-spitter-nest", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "behemoth-biter-nest") then
		if force == "north" then
			if global["regenerationResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "behemoth-biter-nest-regen", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if global["regenerationResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "behemoth-biter-nest-regen", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "behemoth-spitter-nest") then
		if force == "north" then
			if global["aoeResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "behemoth-spitter-nest-aoe", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if global["aoeResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[global["surfaceName"]].create_entity({name = "behemoth-spitter-nest-aoe", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	else
		return simpleRevive(entity)
	end		
end

function replaceInsideArea(sourceNestName, targetNestName, force, x1, y1, x2, y2)
	nests = game.surfaces[global["surfaceName"]].find_entities_filtered({area = {{x1,y1},{x2,y2}}, name = sourceNestName})
	for _, nest in pairs(nests) do
		pos = nest.position
		nest.destroy()
		game.surfaces[global["surfaceName"]].create_entity({name = targetNestName, position = pos, force =  force})
	end
end

function replaceInsideSpawningArea(sourceNestName, targetNestName, force, offset)
	replaceInsideArea(sourceNestName, targetNestName, force, -550,-550+offset, -500,550+offset)
	replaceInsideArea(sourceNestName, targetNestName, force, -550,-550+offset, 550,-500+offset)
	replaceInsideArea(sourceNestName, targetNestName, force, 500,-550+offset, 550,550+offset)
	replaceInsideArea(sourceNestName, targetNestName, force, -550,500+offset, 550,550+offset)
end

function swapBuiltNest(sourceNestName, targetNestName, force) 
	if force == "north" then
		replaceInsideSpawningArea(sourceNestName, targetNestName, force, 750)
	else
		replaceInsideSpawningArea(sourceNestName, targetNestName, force, -750)
	end
end

function gameOver(winningForce)
	game.write_file("biter-clash.log", "Game over!", true)
	game.forces["north"].chart(global["surfaceName"],{{-5000, -5000}, {5000, 5000}})
	game.forces["south"].chart(global["surfaceName"],{{-5000, -5000}, {5000, 5000}})
	position = nil
	if winningForce == "south" then
		position = {x=0, y=-750}
	else
		position = {x=0, y=750}
	end
	game.surfaces[global["surfaceName"]].create_entity({
        name = "atomic-rocket",
        position = position,
        force = winningForce,
        source = position,
        target = position,
        max_range = 1,
        speed = 0.1
    })
	for i, player in pairs(game.connected_players) do
		player.gui.top["ready"]["buttonflow2"]["biter-clash-ready"].state = false 
		player.gui.top["biter-clash"].visible = true
		cancelCrafting(player)
	end
	global["gameStarted"] = false
	global["northSideReady"] = false
	global["southSideReady"] = false
	game.permissions.get_group("Players").set_allows_action(defines.input_action.open_blueprint_library_gui, true)
	game.permissions.get_group("Players").set_allows_action(defines.input_action.import_blueprint_string, true)
	game.permissions.get_group("Players").set_allows_action(defines.input_action.start_walking, false)
end

function resetForces()
	game.forces["north"].reset()
	game.forces["south"].reset()
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
	global["chartNorth1"] = {}
	global["chartSouth1"] = {}
	global["chartNorth2"] = {}
	global["chartSouth2"] = {}
	global["chartNorth3"] = {}
	global["chartSouth3"] = {}
end

function chartScoutedArea(forceName, pos) 
	game.forces[forceName].chart(global["surfaceName"],{{pos.x-50, pos.y-50}, {pos.x+50, pos.y+50}})
end

function cancelCrafting(player)
	if player.ticks_to_respawn == nil then
		for i=1,player.crafting_queue_size do
			local item = player.crafting_queue[i]
			if item ~= nil then
				player.cancel_crafting({index=item.index, count=item.count})
			end
		end
	end
end

function calculateTime()
	local base = math.floor((game.tick - global["gameStartedTick"])/60)
	local seconds = math.floor(base) % 60
	local minutes = math.floor(base/60) % 60
	local hours = math.floor(base/3600)
	result = string.format("%02d:%02d", minutes, seconds)
	if hours > 0 then
	  result = string.format("%d:%s", hours, result)
	end
	return result
end