function onTick()	
	if game.tick == 100 then
		initHost()
	end
	if storage["aiRootActive"] then
		--profiler3 = game.create_profiler(true)
		--profiler3.restart()
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
		--profiler3.stop()
		--helpers.write_file("biter-clash.log", game.tick .. ": onTick with ai step" .. storage["aiStep"] .. " took: ", true)
		--helpers.write_file("biter-clash.log", {"", profiler3}, true)
		--helpers.write_file("biter-clash.log", game.tick .. ": \n", true)
		--profiler3.reset()
	end
	processBiterGroupsTick()
	
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
	--helpers.write_file("biter-clash.log", game.tick .. ": Every second surface name = '" .. storage["surfaceName"] .. "'\n", true)
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


function on303thtick(event)
	--profiler2 = game.create_profiler(true)
	--profiler2.restart()
	tableCount = 0
	removeList = {}
	if storage["biterGroupsUpdateListFinished"] == true then
		for i, biterMap in pairs(storage["activeBiterGroups"]) do
			storage["biterGroupsUpdateListFinished"] = false
			storage["biterGroupsUpdateListPointer"] = 1
			table.insert(storage["biterGroupsUpdateList"], biterMap)
		end
		--helpers.write_file("biter-clash.log", game.tick .. ": Biter groups to process: " .. #storage["biterGroupsUpdateList"] .. "\n", true)
	end
	if shouldDisplayMenu() then
		for _, player2 in pairs(game.connected_players) do
			player2.gui.top["biter-clash"].visible = true
		end
	end
	--profiler2.stop()
	--helpers.write_file("biter-clash.log", game.tick .. ": on303thtick took: ", true)
	--helpers.write_file("biter-clash.log", {"", profiler2}, true)
	--helpers.write_file("biter-clash.log", game.tick .. ": \n", true)
	--profiler2.reset()
end