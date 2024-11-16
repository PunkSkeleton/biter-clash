function onTick()	
	if game.tick == 100 then
		initHost()
	end
	if storage["aiRootActive"] then
		profiler3 = game.create_profiler(true)
		profiler3.restart()
		if storage["aiStep"] == 1 then
			selectBiters("north")
			storage["aiStep"] = 2
		elseif storage["aiStep"] == 2 then
			selectBiters("south")
			storage["aiStep"] = 3
		elseif storage["aiStep"] == 3 then
			formBiterGroup("north")
			storage["aiStep"] = 4
		elseif storage["aiStep"] == 4 then
			formBiterGroup("south")
			storage["aiStep"] = 5
		elseif storage["aiStep"] == 5 then
			firstCommand()
			storage["aiStep"] = 1
			storage["aiRootActive"] = false
			storage["northAiBiters"] = nil
			storage["southAiBiters"] = nil
			storage["northAiBiterGroup"] = nil
			storage["southAiBiterGroup"] = nil
		end
		profiler3.stop()
		--helpers.write_file("biter-clash.log", "onTick with ai step" .. storage["aiStep"] .. " took: ", true)
		--helpers.write_file("biter-clash.log", {"", profiler3}, true)
		--helpers.write_file("biter-clash.log", "\n", true)
		profiler3.reset()
	end
	
end

function every180thTick()	
	chartSpawningArea(750, "north")
	chartSpawningArea(-750, "south")
	game.forces["spectators"].chart(storage["surfaceName"],{{-5000, -5000}, {5000, 5000}})
	
	if (storage["prepareMap"]) then
		if (game.tick - storage["mapGeneratedTick"] > 1800) then
			pregame()
			storage["prepareMap"] = false
		end
	end
	if (game.tick - storage["mapGeneratedTick"] > 2000) and storage["biterAreaToBeCleared"] then
		clearBiterSpawningArea()
	end
	if (game.tick - storage["mapGeneratedTick"] > 2400) and storage["mapToBeCloned"] then
		cloneMap()
	end
	if (game.tick - storage["mapGeneratedTick"] > 3600) and storage["mapToBeCloned2"] then
		finishMapGeneration()
	end
	for i, player in pairs(game.connected_players) do
		if player.position ~= nil then
			if player.force.name == "north" then
				if player.physical_position.y > -210 then
					pos = game.surfaces[storage["surfaceName"]].find_non_colliding_position("character", {player.position.x,-220}, 20, 0.1)
					if pos ~= nil then
						player.teleport(pos, storage["surfaceName"])
					end
				end
			elseif player.force.name == "south" then
				if player.physical_position.y < 210 then
					pos = game.surfaces[storage["surfaceName"]].find_non_colliding_position("character", {player.position.x,220}, 20, 0.1)
					if pos ~= nil then
						player.teleport(pos, storage["surfaceName"])
					end
				end
			end
		end
	end
end

function every60thTick()
	--helpers.write_file("biter-clash.log", "Every second surface name = '" .. storage["surfaceName"] .. "'\n", true)
	if storage["countdown"] <= 10 then
		showCountdown(storage["countdown"])
		if storage["countdown"] == 0 then
			startGame()
			storage["countdown"] = 11
		else
			storage["countdown"] = storage["countdown"] - 1
		end
	end
	if storage["gameStarted"] then
		if ((game.tick - storage["gameStartedTick"]) < 216000) then
			chestFillRatio = 1 - ((game.tick - storage["gameStartedTick"]) / 216000)
			fillFreeResourceChests(chestFillRatio)
		end
		caption = calculateTime()
		for i, player in pairs(game.connected_players) do
			local label = player.gui.top["gameClock"]["clockLabel"]
			--helpers.write_file("biter-clash.log", caption .. "\n", true)
			label.caption = caption
		end
	end
end

function every13thTick()
	if storage["gameStarted"] and storage["aiRootActive"] == false then	
		aiRootStep()
	end
end


function on121thtick(event)
	--profiler2 = game.create_profiler(true)
	--profiler2.restart()
	
	for i, biterMap in ipairs(storage["activeBiterGroups"]) do
		group = biterMap["group"]
		if group == nil then
			table.remove(storage["activeBiterGroups"], i)
			goto continue
		end
		if group.valid == false then
			table.remove(storage["activeBiterGroups"], i)
			tryReformGroup(biterMap)
			goto continue
		end
		chartScoutedArea(group.force.name, group.position)
		local forceMove = false
		if group.moving_state == defines.moving_state.stuck then
			helpers.write_file("biter-clash.log", "Stuck biter group detected at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
			forceMove = true
		end
		if biterMap["position"] == group.position then
			biterMap["ticksIdle"] = biterMap["ticksIdle"] + 1
			helpers.write_file("biter-clash.log", "Idle biter group detected for: " .. biterMap["ticksIdle"] .. " at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
			if biterMap["ticksIdle"] > 10 then
				forceMove = true
			end
		else 
			biterMap["position"] = group.position
			biterMap["ticksIdle"] = 0
		end 
		biterMap["ticksSinceLastCommand"] = biterMap["ticksSinceLastCommand"] + 1
		if biterMap["ticksSinceLastCommand"] > 10 then 
			helpers.write_file("biter-clash.log", "No new commands for: " .. biterMap["ticksSinceLastCommand"] .. " at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
			if biterMap["ticksSinceLastCommand"] > 15 then 
				forceMove = true
			end
		end
		
		if forceMove then
			helpers.write_file("biter-clash.log", "Forcibly moving biter group at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
			biterMap["ticksIdle"] = 0
			biterMap["ticksSinceLastCommand"] = 0
			nextStep(group)
			goto continue
		end
		if group.state == defines.group_state.finished or group.state == defines.group_state.wander_in_group then
			pos = group.position
			forceName = group.force.name
			enemyForce = "north"
			if forceName == "north" then
				enemyForce = "south"
			end
			move = true
			biterMap["ticksIdle"] = 0
			biterMap["ticksSinceLastCommand"] = 0
			enemyEntities = game.surfaces[storage["surfaceName"]].find_entities_filtered({position=pos, radius=15, force=enemyForce})
			if enemyEntities == nil then
				goto continue
			end
			if next(enemyEntities) then
				group.set_autonomous()
				helpers.write_file("biter-clash.log", "Setting autonomus mode for biter group at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
				move = false
			end
			if move then
				nextStep(group)
			end
			goto continue
		end
		::continue::
	end
	if shouldDisplayMenu() then
		for _, player2 in pairs(game.connected_players) do
			player2.gui.top["biter-clash"].visible = true
		end
	end
	--profiler2.stop()
	--helpers.write_file("biter-clash.log", "on300thtick took: ", true)
	--helpers.write_file("biter-clash.log", {"", profiler2}, true)
	--helpers.write_file("biter-clash.log", "\n", true)
	--profiler2.reset()
end

function on303thtick(event)
	for key,value in pairs(storage["chartNorth3"]) do 
    	chartScoutedArea("north", value)
    end
    storage["chartNorth3"] = {}
     for key,value in pairs(storage["chartSouth3"]) do 
    	chartScoutedArea("south", value)
    end
    storage["chartSouth3"] = {}
    
    for key,value in pairs(storage["chartNorth2"]) do 
    	chartScoutedArea("north", value)
    	table.insert(storage["chartNorth3"], value)
    end
    storage["chartNorth2"] = {}
    for key,value in pairs(storage["chartSouth2"]) do 
    	chartScoutedArea("south", value)
    	table.insert(storage["chartSouth3"], value)
    end
    storage["chartSouth2"] = {}
    
    for key,value in pairs(storage["chartNorth1"]) do 
    	chartScoutedArea("north", value)
    	table.insert(storage["chartNorth2"], value)
    end
    storage["chartNorth1"] = {}  
    for key,value in pairs(storage["chartSouth1"]) do 
    	chartScoutedArea("south", value)
    	table.insert(storage["chartSouth2"], value)
    end
    storage["chartSouth1"] = {}
end