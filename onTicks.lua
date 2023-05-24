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
		if ((game.tick - global["gameStartedTick"]) < 162000) then
			chestFillRatio = 1 - ((game.tick - global["gameStartedTick"]) / 162000)
			fillFreeResourceChests(chestFillRatio)
		end
	end
end

function every17thTick()
	if global["gameStarted"] and global["aiRootActive"] == false then	
		aiRootStep()
	end
end


function on300thtick(event)
	profiler2 = game.create_profiler(true)
	profiler2.restart()
	
	for i, group in ipairs(global["activeBiterGroups"]) do
		if group == nil then
			table.remove(global["activeBiterGroups"], i)
			goto continue
		end
		if group.valid == false then
			table.remove(global["activeBiterGroups"], i)
			goto continue
		end
		if group.state == defines.group_state.finished or group.state == defines.group_state.wander_in_group then
			pos = group.position
			forceName = group.force.name
			enemyForce = "north"
			if forceName == "north" then
				enemyForce = "south"
			end
			game.forces[forceName].chart(global["surfaceName"],{{pos.x-50, pos.y-50}, {pos.x+50, pos.y+50}})
			
			move = true
			enemyEntities = game.surfaces[global["surfaceName"]].find_entities_filtered({position=pos, radius=15, force=enemyForce})
			if enemyEntities == nil then
				goto continue
			end
			if next(enemyEntities) then
				group.set_autonomous()
				move = false
			end
			if move then
				nextStep(group)
			end
			goto continue
		end
		::continue::
	end
	profiler2.stop()
	game.write_file("biter-clash.log", "on300thtick took: ", true)
	game.write_file("biter-clash.log", {"", profiler2}, true)
	game.write_file("biter-clash.log", "\n", true)
	profiler2.reset()
end