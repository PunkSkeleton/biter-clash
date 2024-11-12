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