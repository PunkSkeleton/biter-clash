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
				--helpers.write_file("biter-clash.log", "item name: " .. item_name .. "\n", true)
				--helpers.write_file("biter-clash.log", "count: " .. item_count .. "\n", true)
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

function simpleRevive(entity, targetForce)
	a,b,c = entity.revive()
	if b == nil then
		return false
	else
		b.force = targetForce
		return true
	end
end

function swapNests(entity, force)
	if (entity.ghost_name == "small-biter-nest") then
		if force == "north" then
			if storage["adrenalineResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "nest-adrenaline", position = pos, force =  "northBiters"}))					
			else
				return simpleRevive(entity, "northBiters")
			end
		else
			if storage["adrenalineResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "nest-adrenaline", position = pos, force =  "southBiters"}))
			else
				return simpleRevive(entity, "southBiters")
			end
		end
	elseif (entity.ghost_name == "small-spitter-nest") then
		if force == "north" then
			if storage["alcoholResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "nest-drunken", position = pos, force =  "northBiters"}))
			else
				return simpleRevive(entity, "northBiters")
			end
		else
			if storage["alcoholResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "nest-drunken", position = pos, force =  "southBiters"}))
			else
				return simpleRevive(entity, "southBiters")
			end
		end
	elseif (entity.ghost_name == "medium-biter-nest") then
		if force == "north" then
			if storage["resistanceResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "nest-resistant", position = pos, force =  "northBiters"}))
			else
				return simpleRevive(entity, "northBiters")
			end
		else
			if storage["resistanceResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "nest-resistant", position = pos, force =  "southBiters"}))
			else
				return simpleRevive(entity, "southBiters")
			end
		end
	elseif (entity.ghost_name == "medium-spitter-nest") then
		if force == "north" then
			if storage["heavySpitResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "medium-spitter-nest-heavy", position = pos, force =  "northBiters"}))
			else
				return simpleRevive(entity, "northBiters")
			end
		else
			if storage["heavySpitResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "medium-spitter-nest-heavy", position = pos, force =  "southBiters"}))
			else
				return simpleRevive(entity, "southBiters")
			end
		end
	elseif (entity.ghost_name == "big-biter-nest") then
		if force == "north" then
			if storage["sharpTeethResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "big-biter-nest-sharp-teeth", position = pos, force =  "northBiters"}))
			else
				return simpleRevive(entity, "northBiters")
			end
		else
			if storage["sharpTeethResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "big-biter-nest-sharp-teeth", position = pos, force =  "southBiters"}))
			else
				return simpleRevive(entity, "southBiters")
			end
		end
	elseif (entity.ghost_name == "big-spitter-nest") then
		if force == "north" then
			if storage["artilleryResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "artillery-spitter-nest", position = pos, force =  "northBiters"}))
			else
				return simpleRevive(entity, "northBiters")
			end
		else
			if storage["artilleryResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "artillery-spitter-nest", position = pos, force =  "southBiters"}))
			else
				return simpleRevive(entity, "southBiters")
			end
		end
	elseif (entity.ghost_name == "behemoth-biter-nest") then
		if force == "north" then
			if storage["regenerationResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "behemoth-biter-nest-regen", position = pos, force =  "northBiters"}))
			else
				return simpleRevive(entity, "northBiters")
			end
		else
			if storage["regenerationResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "behemoth-biter-nest-regen", position = pos, force =  "southBiters"}))
			else
				return simpleRevive(entity, "southBiters")
			end
		end
	elseif (entity.ghost_name == "behemoth-spitter-nest") then
		if force == "north" then
			if storage["aoeResearchedNorth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "behemoth-spitter-nest-aoe", position = pos, force =  "northBiters"}))
			else
				return simpleRevive(entity, "northBiters")
			end
		else
			if storage["aoeResearchedSouth"] then
				pos = entity.position
				entity.destroy()
				return itemNotNil(game.surfaces[storage["surfaceName"]].create_entity({name = "behemoth-spitter-nest-aoe", position = pos, force =  "southBiters"}))
			else
				return simpleRevive(entity, "southBiters")
			end
		end
	else
		if force == "north" then
			return simpleRevive(entity, "northBiters")
		else
			return simpleRevive(entity, "southBiters")
		end
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
	if storage["gameStarted"] == true then
		--helpers.write_file("biter-clash.log", "Game over! " .. winningForce .. " won!", true)
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
			if player.force.name == winningForce then
				player.gui.center["victory"].visible = true
			elseif player.force.name ~= "spectators" then
				player.gui.center["defeat"].visible = true
			end
			cancelCrafting(player)
		end
		storage["gameStarted"] = false
		storage["northSideReady"] = false
		storage["southSideReady"] = false
		game.permissions.get_group("Players").set_allows_action(defines.input_action.open_blueprint_library_gui, true)
		game.permissions.get_group("Players").set_allows_action(defines.input_action.import_blueprint_string, true)
		game.permissions.get_group("Players").set_allows_action(defines.input_action.start_walking, false)
	end
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
	targetForceName = forceName
	if forceName == "northBiters" then
		targetForceName = "north"
	elseif forceName == "southBiters" then
		targetForceName = "south"
	end
	game.forces[targetForceName].chart(storage["surfaceName"],{{pos.x-50, pos.y-50}, {pos.x+50, pos.y+50}})
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
	local punksBlueprint = "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"
	local blokeBlueprint = "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"
	if player.character ~= nil then
		player.character.get_inventory(defines.inventory.character_main).find_empty_stack().import_stack(basicBlueprint)
		player.character.get_inventory(defines.inventory.character_main).find_empty_stack().import_stack(rushBlueprint)
		player.character.get_inventory(defines.inventory.character_main).find_empty_stack().import_stack(punksBlueprint)
		player.character.get_inventory(defines.inventory.character_main).find_empty_stack().import_stack(blokeBlueprint)
	end
end

function fillStarterInventory(player)
	inventory = player.character.get_inventory(defines.inventory.character_main)
	inventory.insert({name="iron-plate", count=100})
	inventory.insert({name="copper-plate", count=50})
	inventory.insert({name="iron-gear-wheel", count=50})
	inventory.insert({name="electronic-circuit", count=50})
	inventory.insert({name="wood", count=10})
end

function checkIdle(biterMap)
	if biterMap.position.x + 5 > biterMap.group.position.x and biterMap.position.x - 5 < biterMap.group.position.x and biterMap.position.y + 5 > biterMap.group.position.y and biterMap.position.y - 5 < biterMap.group.position.y then
		return true
	else  
		return false
	end
end