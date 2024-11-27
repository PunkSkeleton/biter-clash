require "biterStagingAreas"

function selectBitersInner(area, force, offset) 
	local middleX = area["middleX"]
	local middleY = area["middleY"] + offset
	local position = {x = middleX, y = middleY}
	if force == "southBiters" then
		opposingForce = "north"
		--helpers.write_file("biter-clash.log", game.tick .. ": a\n", true)
	else
		opposingForce = "south"
		--helpers.write_file("biter-clash.log", game.tick .. ": b\n", true)
	end
	--helpers.write_file("biter-clash.log", game.tick .. ": c\n", true)
	--helpers.write_file("biter-clash.log", game.tick .. ": Selecting biters!" .. " middle: " .. middleX .. ":" .. middleY .. "force: " .. force .. "\n", true)
 	currentSurface = game.surfaces[storage["surfaceName"]]
	local individualBiters = currentSurface.find_enemy_units(position, 36, opposingForce)
	if individualBiters == nil then
		--helpers.write_file("biter-clash.log", game.tick .. ": individualBiters is nil!\n", true)
		return nil
	end
	if #individualBiters == 0 then
		--helpers.write_file("biter-clash.log", game.tick .. ": individualBiters size is zero!\n", true)
		return nil
	end
	return individualBiters
end
	

function advanceBiters(biterGroup)
	if biterGroup.force == "northBiters" then
		siloPosY = 750
	else
		siloPosY = -750
	end
	--helpers.write_file("biter-clash.log", game.tick .. ": Advancing biters from position: " ..  biterGroup.position.x .. ":" ..  biterGroup.position.y .. "\n", true)
	local currentPosX = biterGroup.position.x
	local currentPosY = biterGroup.position.y
	local distanceX = math.abs(currentPosX) + 80
	local absY = math.abs(currentPosY)
	local distanceY = math.abs(absY - math.abs(siloPosY)) + 80
	--helpers.write_file("biter-clash.log", game.tick .. ": Distances: " .. distanceX .. ":" .. distanceY .. "\n", true)
	local closeByRatio = (math.random(10, 110))/100
	local distanceToTravelX = distanceX * closeByRatio
	local distanceToTravelY = distanceY * closeByRatio
	if (currentPosX > 0) then 
		targetPositionX = currentPosX - distanceToTravelX
	else
		targetPositionX = currentPosX + distanceToTravelX
	end
	if (currentPosY > siloPosY) then 
		targetPositionY = currentPosY - distanceToTravelY
	else
		targetPositionY = currentPosY + distanceToTravelY
	end
	local jitterX = math.random(-50,50)
	local jitterY = math.random(-50,50)
	position = {x = targetPositionX + jitterX, y = targetPositionY + jitterY}
	currentSurface = game.surfaces[storage["surfaceName"]]
	pos = currentSurface.find_non_colliding_position("assembling-machine-1", position, 128, 1)
	if pos == nil then
		--helpers.write_file("biter-clash.log", game.tick .. ": Biters target position was nil, moving straight to the silo! (group: " .. currentPosX .. ":" .. currentPosY .. ")\n", true)	
		pos = {x = 0 + jitterX, y = siloPosY + jitterY}
	end
	--helpers.write_file("biter-clash.log", game.tick .. ": Added command to move from: " .. currentPosX .. ":" .. currentPosY .. " to: " .. targetPositionX .. ":" .. targetPositionY .. "\n", true)	
    biterGroup.group.set_command({
		type = defines.command.attack_area,
		destination = pos,
		radius = 16,
		distraction = defines.distraction.by_enemy
	})
end

function aiRootStep()
	profiler = game.create_profiler(true)
	profiler.restart()
	local currentPointer = storage["biterStagingAreaPointer"]
	currentPointer = currentPointer + 1
	if currentPointer > #biterStagingAreas then
		currentPointer = 1
	end
	-- 10% chance of attack happening
	local randomizer = math.random(1,10)
	if (randomizer == 1) then
		storage["aiRootActive"] = true
	end
	storage["biterStagingAreaPointer"] = currentPointer
	profiler.stop()
	--helpers.write_file("biter-clash.log", game.tick .. ": aiStep took: ", true)
	--helpers.write_file("biter-clash.log", {"", profiler}, true)
	--helpers.write_file("biter-clash.log", game.tick .. ": \n", true)
	profiler.reset()
end

function selectBiters(force)
	local currentArea = biterStagingAreas[storage["biterStagingAreaPointer"]]
	if force == "north" then
		offset = 750
		storage["northAiBiters"] = selectBitersInner(currentArea, "north", offset)
	else 
		offset = -750
		storage["southAiBiters"] = selectBitersInner(currentArea, "south", offset)
	end
end

function formBiterGroup(force)
	offset = 0
	if force == "northBiters"  then	
		offset = 750
		if storage["northAiBiters"] == nil then
			return
		end
	else
		offset = -750
		if storage["southAiBiters"] == nil then
			return
		end
	end
	local area = biterStagingAreas[storage["biterStagingAreaPointer"]]
	local middleX = area["middleX"]
	local middleY = area["middleY"] + offset
	local position = {x = middleX, y = middleY}
	currentSurface = game.surfaces[storage["surfaceName"]]
	pos = currentSurface.find_non_colliding_position("assembling-machine-1", position, 512, 1)
	
	local biterGroup = currentSurface.create_unit_group({position = pos, force = force})
	if force == "northBiters" then
		for _, biter in pairs(storage["northAiBiters"]) do
			biter.release_from_spawner()
			biter.ai_settings.allow_destroy_when_commands_fail = false
			biter.ai_settings.allow_try_return_to_spawner = false
			biterGroup.add_member(biter)
		end
		storage["northAiBiterGroup"] = biterGroup
	else 
		for _, biter in pairs(storage["southAiBiters"]) do
			biter.release_from_spawner()
			biterGroup.add_member(biter)
			biter.ai_settings.allow_destroy_when_commands_fail = false
			biter.ai_settings.allow_try_return_to_spawner = false
		end
		storage["southAiBiterGroup"] = biterGroup
	end
	
end

function firstCommand() 
	if storage["northAiBiterGroup"] ~= nil then
		local currentArea = biterStagingAreas[storage["biterStagingAreaPointer"]]
		local biterMap = {}
		biterMap["group"] = storage["northAiBiterGroup"]
		biterMap["position"] = biterMap["group"].position
		biterMap["ticksIdle"] = 0
		biterMap["ticksSinceLastCommand"] = 0
		biterMap["opposingForce"] = "south"
		biterMap["force"] = "northBiters"
		biterMap["autonomous"] = false
		id = biterMap["group"].unique_id
		biterMap["id"] = id
		--helpers.write_file("biter-clash.log", game.tick .. ": Commandable created with ID: " .. biterMap["group"].unique_id .."\n", true)
		storage["activeBiterGroups"][id] = biterMap
		advanceBiters(biterMap)
	end
	if storage["southAiBiterGroup"] ~= nil then
		local currentArea = biterStagingAreas[storage["biterStagingAreaPointer"]]
		local biterMap = {}
		biterMap["group"] = storage["southAiBiterGroup"]
		biterMap["position"] = biterMap["group"].position
		biterMap["ticksIdle"] = 0
		biterMap["ticksSinceLastCommand"] = 0
		biterMap["opposingForce"] = "north"
		biterMap["force"] = "southBiters"
		biterMap["autonomous"] = false
		id = biterMap["group"].unique_id
		biterMap["id"] = id
		--helpers.write_file("biter-clash.log", game.tick .. ": Commandable created with ID: " .. id .."\n", true)
		storage["activeBiterGroups"][id] = biterMap
		advanceBiters(biterMap)		
	end
end

function nextStep(biterGroup) 
	advanceBiters(biterGroup)
end

function tryReformGroup(biterMap)
	currentSurface = game.surfaces[storage["surfaceName"]]
	local individualBiters = currentSurface.find_enemy_units(biterMap.position, 50, biterMap["opposingForce"])
	if individualBiters ~= nil then
		if #individualBiters ~= 0 then
			--helpers.write_file("biter-clash.log", game.tick .. ": Reformed " .. #individualBiters .. " into new group!\n", true)
			local jitterX = math.random(-5,5)
			local jitterY = math.random(-5,5)
			biterMap.position.x = biterMap.position.x + jitterX
			biterMap.position.y = biterMap.position.y + jitterY
			pos = currentSurface.find_non_colliding_position("assembling-machine-1", biterMap["position"], 512, 1)
			biterGroup = currentSurface.create_unit_group({position = pos, force = biterMap["force"]})
			for _, biter in pairs(individualBiters) do
				biterGroup.add_member(biter)
			end
			local newBiterMap = {}
			newBiterMap["group"] = biterGroup
			newBiterMap["position"] = biterGroup.position
			newBiterMap["ticksIdle"] = 0
			newBiterMap["ticksSinceLastCommand"] = 0
			newBiterMap["opposingForce"] = biterMap["opposingForce"]
			newBiterMap["force"] = biterMap["force"]
			newBiterMap["autonomus"] = false
			id = newBiterMap["group"].unique_id
			newBiterMap["id"] = id
			storage["activeBiterGroups"][id] = newBiterMap
			--helpers.write_file("biter-clash.log", game.tick .. ": Commandable created with ID: " .. id .."\n", true)
			--helpers.write_file("biter-clash.log", game.tick .. ": Biter group reformed at position: " .. newBiterMap["position"].x .. "," .. newBiterMap["position"].y .. "\n", true)
			advanceBiters(newBiterMap)
		end
	end
end

function onAiCommandCompleted(event)
	biterGroup = storage["activeBiterGroups"][event.unit_number]
	--helpers.write_file("biter-clash.log", game.tick .. ": Ai command completed for: " .. event.unit_number .. "\n", true)
	if biterGroup ~= nil then
		if biterGroup.group.valid and biterGroup["autonomus"] == false then
			--helpers.write_file("biter-clash.log", game.tick .. ": Ai command completed for: " .. event.unit_number .. " with result: " .. event.result .. " at position: " .. biterGroup.position.x .. "," .. biterGroup.position.y .. " engine position: " .. biterGroup.group.position.x .. "," .. biterGroup.group.position.y .."\n", true)
			biterGroup["position"] = biterGroup.group.position
			forceName = biterGroup.force.name
			enemyForce = "north"
			if forceName == "northBiters" then
				enemyForce = "south"
			end
			enemyEntities = game.surfaces[storage["surfaceName"]].find_entities_filtered({position=biterGroup["position"], radius=3, force=enemyForce})
			if enemyEntities == nil then
				advanceBiters(biterGroup)
			end
			if next(enemyEntities) then
				--biterGroup.group.set_autonomous()
				--biterGroup["autonomous"] = true
				--helpers.write_file("biter-clash.log", game.tick .. ": Setting autonomus mode for biter group: " .. event.unit_number .. " at position: " .. biterGroup.position.x .. "," .. biterGroup.position.y .. "\n", true)
				return
			end
			advanceBiters(biterGroup)
		end
		if biterGroup.group.valid == false then
			storage["activeBiterGroups"][event.unit_number] = nil
			unit = game.get_entity_by_unit_number(event.unit_number)
			if unit ~= nil then
				--helpers.write_file("biter-clash.log", game.tick .. ": Commandable invalid but unit not nil: " .. event.unit_number .. " at position: " .. biterGroup["position"].x .. "," .. biterGroup["position"].y .. "\n", true)
				if unit.valid then
					biterGroup["position"] = unit.position
					--helpers.write_file("biter-clash.log", game.tick .. ": Commandable invalid but unit valid: " .. event.unit_number .. " at position: " .. biterGroup["position"].x .. "," .. biterGroup["position"].y .. "\n", true)
					if unit.commandable ~= nil then
						--helpers.write_file("biter-clash.log", game.tick .. ": Commandable not nil for invalid commandable: " .. event.unit_number .. " at position: " .. biterGroup["position"].x .. "," .. biterGroup["position"].y .. "\n", true)
						if unit.commandable.valid then
							--helpers.write_file("biter-clash.log", game.tick .. ": Commandable object magically recreated for: " .. event.unit_number .. " at position: " .. biterGroup["position"].x .. "," .. biterGroup["position"].y .. "\n", true)
							biterGroup.group = unit.commandable
							storage["activeBiterGroups"][event.unit_number] = biterGroup
							return
						end
					end
				end
			end
			--helpers.write_file("biter-clash.log", game.tick .. ": Biter group: " .. event.unit_number .. " lost at position: " .. biterGroup["position"].x .. "," .. biterGroup["position"].y .. "\n", true)
			tryReformGroup(biterGroup)
		end
	end
end

function processBiterGroup(biterMap)
	group = biterMap["group"]
	--helpers.write_file("biter-clash.log", game.tick .. ": processing biter group: " .. biterMap["id"] .. " at: " .. biterMap["position"].x .. "," .. biterMap["position"].y .. "\n", true)

	if group == nil then
		storage["activeBiterGroups"][biterMap["id"]] = nil
		--helpers.write_file("biter-clash.log", game.tick .. ": nil biter group: " .. biterMap["id"] .. " detected at: " .. biterMap["position"].x .. "," .. biterMap["position"].y .. "\n", true)
		return
	end
	if group.valid == false then
		storage["activeBiterGroups"][biterMap["id"]] = nil
		--helpers.write_file("biter-clash.log", game.tick .. ": OnTicks: Biter group: " .. biterMap["id"] .. " lost at position in : " .. biterMap["position"].x .. "," .. biterMap["position"].y .. "\n", true)
		tryReformGroup(biterMap)
		return
	end
	--helpers.write_file("biter-clash.log", game.tick .. ": charting position of group: " .. biterMap["id"] .. " at position: ".. group.position.x .. "," .. group.position.y .. "\n", true)
	chartScoutedArea(group.force.name, group.position)
	local forceMove = false
	if group.moving_state == defines.moving_state.stuck then
		--helpers.write_file("biter-clash.log", game.tick .. ": Stuck biter group: " .. biterMap["id"] .. " detected at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
		forceMove = true
	end
	if group.moving_state == defines.moving_state.stale then
		--helpers.write_file("biter-clash.log", game.tick .. ": Stale biter group: " .. biterMap["id"] .. " detected at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
		forceMove = true
	end
	if checkIdle(biterMap) then
		biterMap["ticksIdle"] = biterMap["ticksIdle"] + 1
		--helpers.write_file("biter-clash.log", game.tick .. ": Idle biter group: " .. biterMap["id"] .. " detected for: " .. biterMap["ticksIdle"] .. " at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
		if biterMap["ticksIdle"] > 20 then
			forceMove = true
		end
	else 
		biterMap["position"] = group.position
		biterMap["ticksIdle"] = 0
	end 
	biterMap["ticksSinceLastCommand"] = biterMap["ticksSinceLastCommand"] + 1
	if biterMap["ticksSinceLastCommand"] > 15 then 
		--helpers.write_file("biter-clash.log", game.tick .. ": No new commands for: " .. biterMap["ticksSinceLastCommand"] .. " group: " .. biterMap["id"] .. " at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
		if biterMap["ticksSinceLastCommand"] > 40 then 
			forceMove = true
		end
	end
	
	if forceMove then
		--helpers.write_file("biter-clash.log", game.tick .. ": Forcibly moving biter group: " .. biterMap["id"] .. " at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
		biterMap["ticksIdle"] = 0
		biterMap["ticksSinceLastCommand"] = 0
		nextStep(biterMap)
		return
	end
	if group.state == defines.group_state.finished or group.state == defines.group_state.wander_in_group then
		pos = group.position
		forceName = group.force.name
		enemyForce = "north"
		if forceName == "northBiters" then
			enemyForce = "south"
		end
		move = true
		biterMap["ticksIdle"] = 0
		biterMap["ticksSinceLastCommand"] = 0
		enemyEntities = game.surfaces[storage["surfaceName"]].find_entities_filtered({position=pos, radius=3, force=enemyForce})
		if enemyEntities == nil then
			-- do nothing
		end
		if next(enemyEntities) then
			--group.set_autonomous()
			--biterMap["autonomous"] = true
			--helpers.write_file("biter-clash.log", game.tick .. ": Setting autonomus mode for biter group: " .. biterMap["id"] .. " at position: " .. group.position.x .. "," .. group.position.y .. "\n", true)
			move = false
		end
		if move then
			nextStep(biterMap)
		end
	end
end

function processBiterGroupsTick()
	if storage["biterGroupsUpdateListFinished"] == false then
		if storage["biterGroupsUpdateListPointer"] > #storage["biterGroupsUpdateList"] then
			storage["biterGroupsUpdateListFinished"] = true
			storage["biterGroupsUpdateListPointer"] = 1
			storage["biterGroupsUpdateList"] = {}
			return
		end
		pointer = storage["biterGroupsUpdateListPointer"]
		--helpers.write_file("biter-clash.log", game.tick .. ": processBiterGroupsTick running with pointer: " .. pointer .. " on the list of length: " .. #storage["biterGroupsUpdateList"] .. "\n", true)
		processBiterGroup(storage["biterGroupsUpdateList"][pointer])
		storage["biterGroupsUpdateListPointer"] = storage["biterGroupsUpdateListPointer"] + 1
	end
end