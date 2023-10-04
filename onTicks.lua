function onTick()	
	if game.tick == 100 then
		initHost()
	end
	if global["aiRootActive"] then
		profiler3 = game.create_profiler(true)
		profiler3.restart()
		if global["aiStep"] == 1 then
			selectBiters("north")
			global["aiStep"] = 2
		elseif global["aiStep"] == 2 then
			selectBiters("south")
			global["aiStep"] = 3
		elseif global["aiStep"] == 3 then
			formBiterGroup("north")
			global["aiStep"] = 4
		elseif global["aiStep"] == 4 then
			formBiterGroup("south")
			global["aiStep"] = 5
		elseif global["aiStep"] == 5 then
			firstCommand()
			global["aiStep"] = 1
			global["aiRootActive"] = false
			global["northAiBiters"] = nil
			global["southAiBiters"] = nil
			global["northAiBiterGroup"] = nil
			global["southAiBiterGroup"] = nil
		end
		profiler3.stop()
		--game.write_file("biter-clash.log", "onTick with ai step" .. global["aiStep"] .. " took: ", true)
		--game.write_file("biter-clash.log", {"", profiler3}, true)
		--game.write_file("biter-clash.log", "\n", true)
		profiler3.reset()
	end
	
end

function every180thTick()	
	chartSpawningArea(750, "north")
	chartSpawningArea(-750, "south")
	game.forces["spectators"].chart(global["surfaceName"],{{-5000, -5000}, {5000, 5000}})
	
	if (global["prepareMap"]) then
		if (game.tick - global["mapGeneratedTick"] > 1800) then
			pregame()
			global["prepareMap"] = false
		end
	end
	if (game.tick - global["mapGeneratedTick"] > 2000) and global["biterAreaToBeCleared"] then
		clearBiterSpawningArea()
	end
	if (game.tick - global["mapGeneratedTick"] > 2400) and global["mapToBeCloned"] then
		cloneMap()
	end
	if (game.tick - global["mapGeneratedTick"] > 3600) and global["mapToBeCloned2"] then
		finishMapGeneration()
	end
	for i, player in pairs(game.connected_players) do
		if player.position ~= nil then
			if player.force.name == "north" then
				if player.position.y > -210 then
					pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {player.position.x,-220}, 20, 0.1)
					if pos ~= nil then
						player.teleport(pos, global["surfaceName"])
					end
				end
			elseif player.force.name == "south" then
				if player.position.y < 210 then
					pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {player.position.x,220}, 20, 0.1)
					if pos ~= nil then
						player.teleport(pos, global["surfaceName"])
					end
				end
			end
		end
	end
end

function every60thTick()
	--game.write_file("biter-clash.log", "Every second surface name = '" .. global["surfaceName"] .. "'\n", true)
	if global["countdown"] <= 10 then
		showCountdown(global["countdown"])
		if global["countdown"] == 0 then
			startGame()
			global["countdown"] = 11
		else
			global["countdown"] = global["countdown"] - 1
		end
	end
	if global["gameStarted"] then
		if ((game.tick - global["gameStartedTick"]) < 216000) then
			chestFillRatio = 1 - ((game.tick - global["gameStartedTick"]) / 216000)
			fillFreeResourceChests(chestFillRatio)
		end
		caption = calculateTime()
		for i, player in pairs(game.connected_players) do
			local label = player.gui.top["gameClock"]["clockLabel"]
			--game.write_file("biter-clash.log", caption .. "\n", true)
			label.caption = caption
		end
	end
end

function every23thTick()
	if global["gameStarted"] and global["aiRootActive"] == false then	
		aiRootStep()
	end
end


function on300thtick(event)
	--profiler2 = game.create_profiler(true)
	--profiler2.restart()
	
	for i, group in ipairs(global["activeBiterGroups"]) do
		if group == nil then
			table.remove(global["activeBiterGroups"], i)
			goto continue
		end
		if group.valid == false then
			table.remove(global["activeBiterGroups"], i)
			goto continue
		end
		chartScoutedArea(group.force.name, group.position)
		local randomizer = math.random(1,20)
		if (randomizer == 1) then
			game.write_file("biter-clash.log", "Forcibly moving biter group at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
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
			enemyEntities = game.surfaces[global["surfaceName"]].find_entities_filtered({position=pos, radius=15, force=enemyForce})
			if enemyEntities == nil then
				goto continue
			end
			if next(enemyEntities) then
				group.set_autonomous()
				game.write_file("biter-clash.log", "Setting autonomus mode for biter group at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
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
	--game.write_file("biter-clash.log", "on300thtick took: ", true)
	--game.write_file("biter-clash.log", {"", profiler2}, true)
	--game.write_file("biter-clash.log", "\n", true)
	--profiler2.reset()
end

function on303thtick(event)
	for key,value in pairs(global["chartNorth3"]) do 
    	chartScoutedArea("north", value)
    end
    global["chartNorth3"] = {}
     for key,value in pairs(global["chartSouth3"]) do 
    	chartScoutedArea("south", value)
    end
    global["chartSouth3"] = {}
    
    for key,value in pairs(global["chartNorth2"]) do 
    	chartScoutedArea("north", value)
    	table.insert(global["chartNorth3"], value)
    end
    global["chartNorth2"] = {}
    for key,value in pairs(global["chartSouth2"]) do 
    	chartScoutedArea("south", value)
    	table.insert(global["chartSouth3"], value)
    end
    global["chartSouth2"] = {}
    
    for key,value in pairs(global["chartNorth1"]) do 
    	chartScoutedArea("north", value)
    	table.insert(global["chartNorth2"], value)
    end
    global["chartNorth1"] = {}  
    for key,value in pairs(global["chartSouth1"]) do 
    	chartScoutedArea("south", value)
    	table.insert(global["chartSouth2"], value)
    end
    global["chartSouth1"] = {}
end