function startswith(text, prefix)
    return text:find(prefix, 1, true) == 1
end

function clearArea(x1,x2,y1,y2, includeCharacter)
	for _, entity in pairs(game.surfaces[storage["surfaceName"]].find_entities({{x1, y1}, {x2, y2}})) do
		if (entity.name~="character") or includeCharacter then
			entity.destroy()
		end
	end
	game.surfaces[storage["surfaceName"]].destroy_decoratives{area={{x1,y1},{x2,y2}}}
end

function chartSpawningArea(offset, forceName)
	game.forces[forceName].chart(storage["surfaceName"],{{-550,-550+offset}, {-500,550+offset}})
	game.forces[forceName].chart(storage["surfaceName"],{{-550,-550+offset}, {550,-500+offset}})
	game.forces[forceName].chart(storage["surfaceName"],{{500,-550+offset}, {550,550+offset}})
	game.forces[forceName].chart(storage["surfaceName"],{{-550,500+offset}, {550,550+offset}})
end

function convertBlueprints(offset, forceName, packchest)
	if packchest.valid then
		for _, entity in pairs(game.surfaces[storage["surfaceName"]].find_entities({{-50, offset-50}, {50, offset+50}})) do
			remainingGhost = true
			if entity.is_registered_for_construction() then
				for _, item_def  in pairs (packchest.get_inventory(defines.inventory.chest).get_contents()) do
					item_name = item_def.name
					item_count = item_def.count
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
	for _, entity in pairs(game.surfaces[storage["surfaceName"]].find_entities({{-1000, -2000}, {1000, 2000}})) do
		if entity.is_registered_for_construction() then
			entity.destroy()
		end
	end
end

function removeAllBluprints()
	for _, player in pairs(game.connected_players) do
		for _, item_def  in pairs (player.character.get_inventory(defines.inventory.character_main).get_contents()) do
			item_name = item_def.name
			if item_name == "blueprint" or item_name == "blueprint-book" or item_name == "deconstruction-planner" or item_name == "upgrade-planner" then
				player.character.get_inventory(defines.inventory.character_main).remove({name=item_name, count=1})
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
	if player.ticks_to_respawn == nil then
		if player.character.has_items_inside() then
			for _, item_def in pairs(player.character.get_inventory(defines.inventory.character_main).get_contents()) do
				item_name = item_def.name
				item_count = item_def.count
				helpers.write_file("biter-clash.log", "item name: " .. item_name .. "\n", true)
				helpers.write_file("biter-clash.log", "count: " .. item_count .. "\n", true)
				player.character.get_inventory(defines.inventory.character_main).remove({name=item_name, count=item_count})
			end
			player.character.get_inventory(defines.inventory.character_guns).clear()
			player.character.get_inventory(defines.inventory.character_ammo).clear()
			player.character.get_inventory(defines.inventory.character_armor).clear()
			player.character.get_inventory(defines.inventory.character_trash).clear()
			local cursor_stack = player.cursor_stack 
			if cursor_stack ~= nil then
				if cursor_stack.valid_for_read == true then
					local item_name = cursor_stack.name
					cursor_stack.count = 0
				end
			end
		end
	end
end

function clearAllInventories()
	for _, player in pairs(game.connected_players) do
		clearInventories(player)
	end 
end

function clearInventories(player)
	cancelCrafting(player)
	clearInventory(player)
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
	for _, item_def in pairs (player.character.get_inventory(defines.inventory.character_main).get_contents()) do
		item_name = item_def.name
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
	for _, item_def  in pairs (player.character.get_inventory(defines.inventory.character_main).get_contents()) do
		item_name = item_def.name
		if item_name == item then
			player.character.get_inventory(defines.inventory.character_main).remove({name=item_name, count=1})
			return
		end		
	end
end

function addToInventory(player, item)
	player.character.get_inventory(defines.inventory.character_main).insert({name=item, count=1}) 	
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
			if storage["adrenalineResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "nest-adrenaline", position = pos, force =  "north"}))					
			else
				return simpleRevive(entity)
			end
		else
			if storage["adrenalineResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "nest-adrenaline", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "small-spitter-nest") then
		if force == "north" then
			if storage["alcoholResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "nest-drunken", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if storage["alcoholResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "nest-drunken", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "medium-biter-nest") then
		if force == "north" then
			if storage["resistanceResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "nest-resistant", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if storage["resistanceResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "nest-resistant", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "medium-spitter-nest") then
		if force == "north" then
			if storage["heavySpitResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "medium-spitter-nest-heavy", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if storage["heavySpitResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "medium-spitter-nest-heavy", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "big-biter-nest") then
		if force == "north" then
			if storage["sharpTeethResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "big-biter-nest-sharp-teeth", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if storage["sharpTeethResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "big-biter-nest-sharp-teeth", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "big-spitter-nest") then
		if force == "north" then
			if storage["artilleryResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "artillery-spitter-nest", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if storage["artilleryResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "artillery-spitter-nest", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "behemoth-biter-nest") then
		if force == "north" then
			if storage["regenerationResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "behemoth-biter-nest-regen", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if storage["regenerationResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "behemoth-biter-nest-regen", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	elseif (entity.ghost_name == "behemoth-spitter-nest") then
		if force == "north" then
			if storage["aoeResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "behemoth-spitter-nest-aoe", position = pos, force =  "north"}))
			else
				return simpleRevive(entity)
			end
		else
			if storage["aoeResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "behemoth-spitter-nest-aoe", position = pos, force =  "south"}))
			else
				return simpleRevive(entity)
			end
		end
	else
		return simpleRevive(entity)
	end		
end

function replaceInsideArea(sourceNestName, targetNestName, force, x1, y1, x2, y2)
	nests = game.surfaces[storage["surfaceName"]].find_entities_filtered({area = {{x1,y1},{x2,y2}}, name = sourceNestName})
	for _, nest in pairs(nests) do
		pos = nest.position
		nest.destroy()
		game.surfaces[storage["surfaceName"]].create_entity({name = targetNestName, position = pos, force =  force})
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
	helpers.write_file("biter-clash.log", "Game over!", true)
	game.forces["north"].chart(storage["surfaceName"],{{-5000, -5000}, {5000, 5000}})
	game.forces["south"].chart(storage["surfaceName"],{{-5000, -5000}, {5000, 5000}})
	position = nil
	if winningForce == "south" then
		position = {x=0, y=-750}
	else
		position = {x=0, y=750}
	end
	game.surfaces[storage["surfaceName"]].create_entity({
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
		player.gui.left["team-join"].visible = true
		cancelCrafting(player)
	end
	storage["gameStarted"] = false
	storage["northSideReady"] = false
	storage["southSideReady"] = false
	game.permissions.get_group("Players").set_allows_action(defines.input_action.open_blueprint_library_gui, true)
	game.permissions.get_group("Players").set_allows_action(defines.input_action.import_blueprint_string, true)
	game.permissions.get_group("Players").set_allows_action(defines.input_action.start_walking, false)
end

function resetForces()
	game.forces["north"].reset()
	game.forces["south"].reset()
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
	storage["chartNorth1"] = {}
	storage["chartSouth1"] = {}
	storage["chartNorth2"] = {}
	storage["chartSouth2"] = {}
	storage["chartNorth3"] = {}
	storage["chartSouth3"] = {}
end

function chartScoutedArea(forceName, pos) 
	game.forces[forceName].chart(storage["surfaceName"],{{pos.x-50, pos.y-50}, {pos.x+50, pos.y+50}})
end

function cancelCrafting(player)
	if player.ticks_to_respawn == nil then
		for i=1,player.crafting_queue_size do
			if player.crafting_queue ~= nil then
				local item = player.crafting_queue[i]
				if item ~= nil then
					player.cancel_crafting({index=item.index, count=item.count})
				end
			end
		end
	end
end

function calculateTime()
	local base = math.floor((game.tick - storage["gameStartedTick"])/60)
	local seconds = math.floor(base) % 60
	local minutes = math.floor(base/60) % 60
	local hours = math.floor(base/3600)
	result = string.format("%02d:%02d", minutes, seconds)
	if hours > 0 then
	  result = string.format("%d:%s", hours, result)
	end
	return result
end

function shouldDisplayMenu()
 	if storage["gameStarted"] then
 		activeSpectators = false
		for _, player in pairs(game.connected_players) do
			if player.force.name == "spectators" then
				activeSpectators = true
			else
				goto finish
			end
		end
		return activeSpectators
	end
	::finish::
	return false
end

function addDefaultBlueprints(player)
	local basicBlueprint = "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"
	local rushBlueprint = "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"
	player.character.get_inventory(defines.inventory.character_main).find_empty_stack().import_stack(basicBlueprint)
	player.character.get_inventory(defines.inventory.character_main).find_empty_stack().import_stack(rushBlueprint)
end

function fillStarterInventory(player)
	inventory = player.character.get_inventory(defines.inventory.character_main)
	inventory.insert({name="iron-plate", count=100})
	inventory.insert({name="copper-plate", count=50})
	inventory.insert({name="iron-gear-wheel", count=50})
	inventory.insert({name="electronic-circuit", count=50})
	inventory.insert({name="wood", count=10})
end