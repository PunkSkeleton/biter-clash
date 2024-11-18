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
	if storage["gameStarted"] == true then
		helpers.write_file("biter-clash.log", "Game over! " .. winningForce .. " won!", true)
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
	local punksBlueprint = "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"
	local blokeBlueprint = "0eNq9XV1zI7eO/Su3/Cyl+P0xj/d1t2of9jGVSnk8ykQVWfbK8r2bTeW/r9TdkqhJQzwHyvjJYls6DYIACIIg+MfD58376nW33u4fPv3xsH562b49fPrxj4e39dft4+b4bP/76+rh08O/1rv9++HJ4mH7+Hx8MH5j+c+HPxcP6+2X1f8+fLJ/Lohf/mfzS0f98r+aX3rql//R/DL8+dPiYbXdr/fr1djpofH7z9v358+r3aE7l18/P242y9Vm9bTfrZ+Wry+b1QH69eXt8NuX7fG9B7xlKD/ExcPvD5+ysT/EP4+EfYPozojr7dtqtz88m4FJVzCLhy/r3eHFwzfKDKiHQDMHGti+x17fI4f4DRdmABPQb7bbmSSy9ogsCJGFI7JCA34Bdd+ChhlQa0hUD6FaCDXKqNbNwToS1mGwiCo1gokxNnCgGF8jAlpZtiYOFeRq1tvRMK9VtpA2T8KppEEWcJxhuxjOkFGAtHoLLFHpSEifu1R6DtLXLiI58zTdlhD1M4/ESHLqkWD0s42ESE43EkxVy55185DeaIdVRNQriK0CpFMTKSFe9GO/e9y+vb7s9svPq81+BuyE5QQ59kGBJYywv+jE5/fddrVbyvISr8D69t5ftOPzy3ozB5mbnnbnOt+oyX71+Lxcbb+utzPDYc0VC/vAF215Xb/OAfrumJCa0iAKIxMM2tvE9Tbo9cUlgVankMgsYGk0RaJLPYeIiFFBnWATQlJgFQEra/S4QnocCqzHBRLAyusxBBwNrscCH6NV67EwytHxeoz1VqEoXlqTK6YUbwQszZQygPVFMcJTircQD/kpBQTGpxRxTCotOBhtyagnAO+FEIxVyI+EpZhMvOAbJq+dAETqNJoiOA1JMZl4wV1ISaN1EdK6lGGtC5AAFl7rMOCKa53Ax2y0E4A0ytnyegz1NmsURfC6smYyEXykHDSimCBRzBEWxQzxMPGiiAFnXBSlMSm84GC0sYuVM7zg45Rrx2u5f1l+3b28b7/MBH6usPoDXmyHj65LnEZNJCyNmgiuZgkw06LMtLnxLbHDs9TtZ+IkpHQBs9qsSohF7cUEwXMtFR4R18OqhpcUEUvhXQXBq6y4NsQrrK7UVVw3MomM+1yFRMY9sCojz+7NJa3nKUoBvX1yRhR82Vrg3i8vAo9t9tSKYxsS2xpcuZaWBse1jcfGtY9nildYL4/IsjW4AnqabFwFHY3dKOHrZr2f3wa5rSTWZACkJWwWpCjMLjg4FaAvXViHbNYbhSl3ELXWKqDBXWuLa1eisb1ippBEygYFGJZkYHF1sobFxgPW1rLYGcd2LDaufNaz2EjmQIMqiQSbOWBjH5KYyALZbYerWkMpiI1k39jQ7z+uZTaxNBJqlllsJKvA5n7/CZUqLI2ESrEmzEEqVbr9Z1MNnOlD4irlWOvqcZVyrHX1iEo1qGL/cZVyrJX2hCPIWmmPqJRz/f7jKuVYk+pxlXKsSfWISrn+lBJYlepbqUCoFGulibwEx1rpAKlU6vcfSQt1fZ+SyExwrLUnMhUca+2bzAW5/75vmgOuPp41zQEPZnjWNEdSpXzfSkUk2dr3fdKIq49nrT2RveBZax8RlfJ9BzLiKuVZax+TNmFWJjcrt3VClBAvOvXyyy9vv77sVsvX9+fXW6GZAIUBYlXEQzDoZBTQEYO+2spdbZZPv67ebkbhJc4SSQ61D6aJTUiZ8El/4idkCTMqhiRhQ5IU0BmDzgq2iiwoCrAkgVX15oJEXzbq3YUiQVrF0BRoaLJmF6ti0BplqhILNIE+kZ8XLdq9PP222i/f1puXGzsHcUyqO/R3/dr86vVxd3z/+Pjn/3l/3Bxec/j39mV3GPmH2VcrtCwajN9ZAW0xaHKLOF2RPotY+fGMVjq7ZBRgEmXFavU3Sv5EUShZxHYBiDyKeEUnAK1QOZkFiv3hKO0BsUkVzcwaxfNvuPYsL8ueCOWX2ULsD1/WPSg4dOSugcVctAodX21YAcKy6nVZB0fJbWtSMd63X1a7cbdW3IAPNxi8OJ13X29f3/ezJrxCx8MvMSCUMQGCDSxsZPnt+/xORLrDDV2ZJzgzg3mJid8azJf3vTia0MFXW1m2Q0p5ib1jsM6wzuVld0MaTUekaSwvO4aYcXIGOlduPcsHSAcbakFYSAftDQs9u+ftmtSM9e5lK612l9b05iln2LnP2r4EZGw1vvR9KDaZ0PQhK0hdv6PWYFB9oiw5jfU5Zx1Gm+sjaXxCyDg7It/ixvw3ryRWcYgD1GurzcKVeawIachgipCGaCCsOqQhQjYpFY9vb6vnz5v19uvy+fHp1/V2tbRzhuIipXlmWj4vpEcK316HZKvldhR4Yj3tmtQMkLTGn/zOpDmatPRRpHmaNP9RpAWaNPNRpEWWtMb7+s6kJZq08FGkZZo0+1GkMctymabZKcchyaRLR2F6wyc9o9CWTx5GoVk7iFrB/cvh97+877aPTyty5KE0nnKDjlnQQIEmDFQTOMtSbaGkAEsS2EWxNy+HEf318bBc/7LEYlAVE51Cv8Kwr6j6eFSVCi4ZluwmWoSR3ST7oK8I7CucPnIkcsazZNvKkh3oVxT2FVEfhRE5k2iyHUs2rbDWs68o+uiEyJmq3pApUv0yo5n4oR1VF60GG2MvkUd0OWeG0u012CDdQeG4gGRHBTRIdVL4RCDVWQENUl2gWOO3Yv35cTeVG/4LIBLKDjIDZt2ahOwusZNiIoNyoWt7EhK+TiyZiPOZWVDO+QRHSeN8irzUOJ+SBU9ZG9ETydMfg09ScepEnN0N5goOCJhmYhYLVkaflafMTGOFJp2YyC4JmzA6MZX5RKMHAj3T6JFADzQ6sXPrI43O5FB4Gp2J1jgavepXswlK0HLF6Fez6CusJosF5VFxmjQWGJ1xQGmLQ2QzNUt8GJ3QWkfbhJL0i31UcLI+ZIG+gimSQVu2Qky1jrZsRBGaJgwCo1soVtzYtG9RF1OKy8+vu/XLbgx/bla/HMkbEpn+8nyWDC6N6ob5OxLUTb1x1WvSiGCmMgpPGyui3k0TX4LRiWna0saqZn2EDNT1WvRxPvQVlcoTy5C0ill/nqqUw1p4T+VgJRrdqdANiO6pgYh3mg1P1NBp34byilHsQKMnTa4djE7439bT6EUfocZ02puqj1CDr2hSwBBpNXeaDcsoNjvHecsotqXRifm50OCEFlcaPGooB+0dUbxnWWlwQoXpeYDIM1vSU5itGspBtjijoRwFJ3SUtvhEfZ8lPVk5r6EcZUvQUI6CR8UuGQyeFFtZ4PxB1AJa0hO4KiEJBq+KWo8gV7ymjmSCKov6JjUJmLFvzKHA4R7vFXUlUR55BTR2X2WTedRnkUU4dMP/9oo6k2g/FDuuf+X+vBRlvvImCl34xHUUWlHdAYQOhq/xiEIrSlOi0I6vYIxCK86rJyPdLKa+MEnaTPREXaJ2uw86R+yJwkQtuMfAM3QppJFh52e0UFS7WR4Th6raiMM4QiUgeZYvVArSDUkR0KkwcbPL5HTxnoidty3k+DY5SbeC7hfb575H0N1H3c4RptUxqcBBGc6q/RxUygq1GREhKZP9vshsHzm2M0m3fYSiQ1dCO08qSHIqlmDC094ndUP7mpkG4kRQ7SihfI6qXRkUPVGByXKvWU38LtC1+ZkF5WPEqQ/KJgDb2MXMXBjY32lesuqMPSo62Slj2krRyXwW/7XLOAuKnb03faCoCoqjvEYK4C5LXwAhn7ivcZmaJ++dJnPVBBxB1hZNVj4MbjVxOxTcKe5ogcG9JraGgisy82FsxYF+0H0oiVxRRpDkrFoGB4zoogKPGDh9SsZckT97FTd/7r/IPGnPbg4nE76uHnfLf/+6Wm2405u+Qg5vk9kLjn5lT7w1rxB5CK1em+gEJktttahbFWUa4Hg55zHfe13mMUhvUoFjsl+hubSJo4A0Q6WhmlRj6NZ435aGujl0Hh26QJeFaogWBDcYurKGN5jyj8S9bA/kPa13T+9r8tx+aPKZ0GTVwg1SMJ49/Fr6HA1USCPfENe+qxaaRCaUSZllEl11wkVMRJ5eXl9Xu+XT4+fNihWOTEZDwL4WVTQEsjTB6KJPkHUM1qiCIiC4VYFjbLH0CXTbVUJLl76xoE/zy+Hx4+75gPX18f/G64UZubV04RsbP4awqC/gMqNcDWFf37fL/ftut2InAAu5/5VUccveC1r70lZY3uUPcKADk6vFmhsH1Y215Ng0OVo3naZr+zWL5BSJACCRXgGNmUIiGevG5DNPtWaZjhW+DEQmVmDljN1UTiDJulV6woiuKnCo0FLwRh8CECoGBW/vCAHk72fBvCNDAODoe3a5LjKOX6CnzirP6xbomGR63QIdlEx2gS5ylV2SQ0W2gueX5L3BCuaO5XP+rstnRe2oQjKUrx1VumMfvHL5nOXls7zJFfg6Us0rQS7FO9bP+Tutn0Mi189gX7O6mpgsEbo1OWaz6LJTrj+btlfU3TroS1nuqFuCY8NGVZxiHRam5FSTUAFSHlTgGQPXHf8FwZMKHJQWaCq216ZsFgi7OCH1garqZC3GSybzqqEVBAcXpTbMuQ12FtKpDreC9HrV2VYQPOizdCTRaDKusDOgmGlISXVOFuRDVqX6gOBFldsCglfVWVUMnClWxVpjJruKNcZMpSrWODF1qljblFWn90BsSC1vGJD5tXebWnVzFdb1s7LqkB7mtDBlqBw5OWfW5/RdE1rIcCxmQQsdjhXpgwI5rLXR5UxhAlDYjZpbzG13Q3ar7eMXdrlWEF1k57CiCduC3MsKaEx7lPlVBQPXRW6h4p0Bu2uvCdcWzKJiiVINbgVx70iUEupvBqYaVBM0rZBAM8WgGvCCgevispjcKROnQLnTFWxEpaSo0FHZrvqcJ0EGozHkUTNI+qKxJGzBYJ3qdBckd9F4FXjFwAMZYwT5HElYkM9JFWYE+ZxV4CCfsVrgbeROVI2qCgRiHLaY3pkuley1fG3MR8TUhWTAnutCMiA4dqQm9lmAxWFCH4i+vRIY88wlA4k4hTvZI+JUTaQDG1GmDhI7nTj1xeciKxy2S9/H8ZqTQZgBZsocsfaXqXLEThwucQtnUAiyZuEMcqNosEFuVO29s6LQeUOtrDH+eu29sTKZTrGgxpjqvbqISZGoDdyKNGPFraJXFUfJBuODqjhKthh4VmdtZSNxueiztv7Kk78tayv6ymVtoaMfDJe1BY57sGwO10SwmBYUg9Ms51F6vQock9MQuBwulObIZXRlqGhcDInN6OoPXdZndN1WqnszumIo+owulKFVl301Iwb9w0sxGn3yFdihaPXJV7eHU598FaPjIhhoX70myABqMJNo4xxpdZpEGzCCIU6Kkb9Fg53LI3/Xcb0xlI1Mva5Xu6cj2KB2b8qzPDFqNi/RzmsOlYAyljT1RUG6k9Vgg3Q70t3FSitEJpOn8UgdRnRQgXsMPOrdXaHiS0zpDnfXfz93N2XS3UVHv6i332QeVtKFloCaRB/UaXYdz4u6iy6Q0p51Hjkm7dmTTrPI1UC6yQ5yDHKk3eTuYCX1vpzc+3tcb/9dXe98j+sNDlJVH6YQOVqM0p33msMUsdg7/HmMS00iEe/P++/kzxdP+vNgX3UuN2YQqbvsHGkQS1IfA5FlOWu2JmW4csc6AWRx1WT4Z6z8b8SyiZqVh8SJajWZ+TCZjttUlMn03DanDBQ0qdtwf1V1CWF0ri6hzANuN1XGgXZTgTGpiq0/kGmJudTN0eCaioOYAUmGy5rNUMXfZDRZs5jhT9StbSw3qBxYlBmKHFiUF6oqgzlg4IUMOQRQnFUJsBkq5pC4W9maZVhURJcTU7SoWaZC5TSS1a0nscFl0oWaNRs4xFi+ULO6ADkSNRc7o5KjKnGfI8iRrEIHB7NoqsKjfFGVFEP5ghX5cZ6UFOYmtoZojN1NMtKtw9eNYYQ44dXHxLNQoig51dXFKBsiuToQqUzqXEsZM2vSIVH7RiUgRRq9kssQiQnekAsjEciqsy1lTKfIQERZSFyR1ixBUPDArWxEDkRupSXisPqT+5CZW3SJOJp7CGU01cYgOBMFTdF4VGSCagmHgjvNighli2oph80gWCaQIef+ELUZnKLgQaVsWB+FLWTT14+guD8QHaqqzeAUqWWuLmvWgdC54sTUsmmWsCA4szKrLDizMissOHN8MbPgzPHFxIInxOn2J1DoDHFibh5r1u8JAy+q9TsIzkQznQw+b/ST6lZBGF11q2AWajQkptKNtzSx9LKs9ikOqjgGJtNJFyTBxC5hNd2yTLPA5UzioqNX7tjLTd8toScxFXKcJ00lUyGnCX5g4pV1kRVMvDKbtQqKF1Mfx9EmIoc7kjVvVl98Xh9E6XH3+/Ltab3aPq2Wr49Pv5Gilll3+HrQZiGTZk0goikKeaDyVPhbr1E9qOzmfuNPQafQU9HuZRRNak0quuQ46MheYi42azytgoGrKn6glAd9Gppw1C4xmTGNy1IkOKa0h5GZO2/eqKyYSqMXlbuColfSrwBx+QvN3A25+/v8iqqbnTFNoIv1NBO1pAlVd6AEswuVrA4Cjz6281H6vad3Pmofk6zLKgNhdVn71o4usGO7cpOxAjtN9pMIBJXUSX0cpw7Ci5CeC8KLOJrCBDKaphRBhg61Z6ZAjue8qYxd52VYVE0pApQblYo6YwQTl3gFkl4iG4b08DKRC0P6d7nJhLl5ciGchbk0B3znGcG6jJfwdhEOHWasck4DZLEx40881Stabxw0fCWT3DN9b9ZlSSXzrWjWBsVgslNV4NBxwsyU6Lmsx0DKnWqxh1Lu9KdsbguVAMcImfNcblrBSkdkB97Tc1lstHbEzkKqDlCAmu9UxehQ8VKdpEApL5p7KlBw1YmKGamdA/dGc5UESLm3KspBcKc5wYGyxavAQcqD5uIGFDxqEsFQ8KTJYUPBVbcLoANaNPcioJRXFeUYOJMFZC3JFiYLyLJWkcoCYq1i0OTTodhBkQiIYkfFxQjoaCbFhQ4o3VlDN4hdFBc6oDypGmyMbipfiMW2isADiu0UARMU22s398QFE5Ui1EeLVNQFFLOo2YCUadSUqkQHqGjveJhecN+tDjlSMSSQ/UkRQwIXDonMNL9W9FlE1c5jcRi5qp3H4jHwoFqjg5Sr7hpAKdeX7iheGsc7SneU27V5LorBqBZdPKeJKYidxPYr3dVgzwFlo96rkzGx2wdsH8hxN/7JQOz016weRUyy1rkMhO0Smj4QvUsIDAF3Ol/GKdQNXjIOu0fY5z92YVVf7At9+KkPyZ26l3E8NbuLMEGb3C9DRtXECB1GyEV1lQ0KrsoJLxEDV+WEo+CVjGxjR4ByJS+zKQHExeaTROM6Ehflg6cj/OES4fezkPymQexBMpsGrOYxl0g5Vjkq7eE1Tku4uW30vn95fjw+vyOTNlc+mdx8KH2VzkPOH0hfMXTSnA0fSh9dyLlxtD6CPnpbtXwoeZ4lL34oeXSWvvtQ8iJJnvlQ6tg0Ef+h1GU+Owibk4rRpY8kDFyXPgIdUChWlz6CUW516SMg5fekj6S/P9JTmGJJjhUCG1TgICt1GSTQ5b7FJjJYJZwAKlaXLQJSqcsWAcErGRKTWOB0mSEYlU6XGQKC6zJDQHCvSt4AwQMZhhQHT5cFAlKpywIBwTMZ7BRZoMv4AKnUZXxg4F6X8QGCWzIGLPHX67I7QCo9FwwWiVRlcoA0Rk0GCoidNNkWIHbWZImA2GTwXRy3qsmswGhkEqpY0xgsF+GX+h9UGRogjZobR1FsTSlcFJvQN9beEJlTNDSubjRHEG3re3oBcRn7PjORDcWKLJEMxUpsVNwxikJ7RRAAhA4K6IRB42rGzjxEkhQ78RAZU4llCO5Isi4EUTOJ9SCIjChrSY4Q5ZKsYbGdBhvkidfwBMTGNZJeEBCZUfRKJuE6Sa/lEjH1sRYw4VrZrPFBGcTV0rLWhCiFRIcPiEpIdNyDuEuMDtgQxZDoSFPG9ZKOtWVcL+kgIVHRyHlWBnG9/CZWCmAXDd0gT6qGbgy7EN4ra6uIOkaOtbFEGSPH6jxRxcixtoq458tVUgaJVC/H2hMi08uxdpBI9PKsPSHyvDxrB4k7vzxrqyqul57V+aq6LKVAVRxK1WX5Fwzcq3Y7Qcp1Wf4g5VGfiC8UgCk13bE9e7P21V/6z2zS1qxPxy9SVwtXPgwdcqb6Z5KHfE7NKnUVWWbBrWqzGmJLNU4FXjBwT25Wg7BBf85CkLoK3ULWbiqDpCb9YQmR1Kw/miBiFvVRABGSPF1guogWyYnu88+SZwtSHxFJfi59GERdbF+W2VJI1vUhEfWwoY+DpK80K2ARh9QBC3AfmXccIKXQXkNffxx5msz1ue+QvTvXl3eHyLvvWx32+i3f5z6UX+L7Au+i+niOCJk07nKFyj9VpvjPxaNFwVUJmdVg4FVFOQbuyWM0FSs8VbEckwbXgLiOPZsyIQ9nU+IsJH2CptoepCp9EhQ2rzpLg8pD0h93qTerpG1evq7f9gf7oM+prj7rD7t8AHXN1eqPn2/4SVUo+lCbnJdZhNpFaDJbZhEurowMYTsQsQ/hOhClD+FvQ1xWGjJE6ECEPkTsQOQ+RLoN4U0fIncgfB9CN0NBZRtqUB0ZqFDZhhpVRwZQcNWRAZAt8Y4jA399xd8Vk6p8eZ5yxdVZzMDFpKqTgKImCjXDrVnwpAIXO626Prl6jNaimuVByWRifYGknLmny0UW3HIRM5AhTD2eBhyk2WvuVULB9bE+UQmp27osS3DiAonoCGZ1IFHmQ1EHEmVMdU0REZItq2P6iGQE8JupcRaSvYogXDCjhOnVpbllTP3NOjJmvMMRiLccgTNxz+vtEfPLbr0hr2epOZFLdaziRW2r+YDr6nC79nTNRX1phzw4pEJeSs2LkMVoY2MyJFvvJ1zGK0mYUEmSBgjaUq9Q/Z9lyFf09Q18gVzMkFhY7AqDKDNhXvoLu7HVvEIcsMxdfoMOGK1Vrk9q5c6YgaNVyRt2UFhLnTVDZYC+m6p2+VoR5WqUAJMA6E4qWmPZPI9vdHcWEpmrAj9QiGJ9Y1GB/pN6FYDhr6TJhjIorDFGP70IKTkHUEtabBnJkVOKjORJc4/dvnYADnp7L1MbSYOPDnfSW3yZ2EzaZhmpkJOHjFQ5w46OtjVqyy7Sai1n2sGxhnIvENWxXm3OZczAGV4ZKHITAzzQSW3DZVqbUMV+tdpIK6OTfBczlJH+afHw7wO9bw+ffvzRLuIiLOJPi+HTAfD00ZnhYzh+tMPHePiYz59cHD7m48dw+TgB5MvPjkDXn13zuY6f/QXRhW8++5ESFy/4x58t/Ih5/PfCj5h+6M703B0/j6T54/fj+Pz470WaenfET37s1PF5Hp8f/704eLPD5yNtB3dh6OLwvP080pNr8/z4uTbPbRwbx+8u7MTXI/jCppG8I/rha6lppJExdfjNRNXw24Wd+DH8XdgwtcLQilMrmgZxIOCCMrXG3g0kLOxE+/Daw2DVaRQHlGKnVhn+N7XKKCTpqlXaVphQjtgLl6b/1UHOamxazk/frMMQG9O2wklaTPO+qRUmKTHDG0KZWi2dw99DK7WtdPrfSNkkU3YQqkliBpoubx9aYaLs1PKTjLqWlqEV7PS7EFvKhpafhnZshUkEhu+ceTa2wqSOA70XOo+cXPgyfnOgdxH9SMuAfX77qZXb1vSGsRUnLg1oC19d0wqTnE2t0/+qazgxtWptWtGP7xu+c3ifa1v11PINnVPr9E07Km5uWxOXhr5828q1acVppAfqL7SMrUkGQ7h6Q2j7MLbiCTPkhmdj68SzqTVpzvCdC2WDVp2/OZiBONnAcMWzcM2zsXWisw6/y2myT7bp39hK7mS7UvOGsZUm+zg8PfyvNq3kU9vKcWoN7zv/7thKk1wPTw+taQI4ytuhNWH6gRNp+ubx77kPY+t4Z+TYKm2Phlae5HN4eub82DpeTz62asPrsZVOdnuwL2dOjK3JXg9PD/+7ak0yODw9c2lqnX7nWy5NrWnEhqdnvoyt4/24Q2vQ6ROXptbE3bF1vNNkbB15lidLNHBykafeDj07931qnageWnni7oB9efvYmuz18Pszd6dWmno0yNm5t0Mrn+a+mtreDq1jKfqxVdv3ja18mg9d07+pNY3mMP5nWobvnPs+tSaqh6eLak+t1PR2bJVp7sij9ExUj61ymneHmetE9dg6JrOPLd9SPbSqObVSS/XQOmaBj63a0jlO89OMNzxdHBOxx9axt3XyYQZ6z5SNrePmwNjKDWVTa+Lg8PRM2dQ6OQympWxqpVMrN5RNrXxqlYbOqZWu/ndyPExtxmFqTbweni7qpNPD30Wdxnb4u6iTlzP8XdRJN4e/i+Oe0NgaOFGmb0bf9m9s5ZN7FNr+pdxSPbbKqVXa3o6tSXPG1rBkHZtXXRpbp6/moYP55IO5oeXb1mSKar4idHCRzsTk8YV2esUoMaf+loEzkyyPrWGRMDZt+47BpA2hlavm9M5y1cly3clBsy8kjMJXS9MalmNjs7Q0jBiX347fO/3/sIRY71fPh4XH58376nW33h6XHZvHz6vN4dk/Ny+/rf7x3/vH3f4f9gdz+M+/Vru3YT0Sk6uHeS2G7J3xh8XI/wN64gAj"
	
	player.character.get_inventory(defines.inventory.character_main).find_empty_stack().import_stack(basicBlueprint)
	player.character.get_inventory(defines.inventory.character_main).find_empty_stack().import_stack(rushBlueprint)
	player.character.get_inventory(defines.inventory.character_main).find_empty_stack().import_stack(punksBlueprint)
	player.character.get_inventory(defines.inventory.character_main).find_empty_stack().import_stack(blokeBlueprint)
end

function fillStarterInventory(player)
	inventory = player.character.get_inventory(defines.inventory.character_main)
	inventory.insert({name="iron-plate", count=100})
	inventory.insert({name="copper-plate", count=50})
	inventory.insert({name="iron-gear-wheel", count=50})
	inventory.insert({name="electronic-circuit", count=50})
	inventory.insert({name="wood", count=10})
end