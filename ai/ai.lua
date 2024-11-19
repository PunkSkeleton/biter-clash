require "biterStagingAreas"

function selectBitersInner(area, force, offset) 
	local middleX = area["middleX"]
	local middleY = area["middleY"] + offset
	local position = {x = middleX, y = middleY}
	if force == "south" then
		opposingForce = "north"
		--helpers.write_file("biter-clash.log", "a\n", true)
	else
		opposingForce = "south"
		--helpers.write_file("biter-clash.log", "b\n", true)
	end
	--helpers.write_file("biter-clash.log", "c\n", true)
	--helpers.write_file("biter-clash.log", "Selecting biters!" .. " middle: " .. middleX .. ":" .. middleY .. "force: " .. force .. "\n", true)
 	currentSurface = game.surfaces[storage["surfaceName"]]
	local individualBiters = currentSurface.find_enemy_units(position, 36, opposingForce)
	if individualBiters == nil then
		--helpers.write_file("biter-clash.log", "individualBiters is nil!\n", true)
		return nil
	end
	if #individualBiters == 0 then
		--helpers.write_file("biter-clash.log", "individualBiters size is zero!\n", true)
		return nil
	end
	return individualBiters
end
	

function advanceBiters(biterGroup)
	if biterGroup.force == "north" then
		siloPosY = 750
	else
		siloPosY = -750
	end
	--helpers.write_file("biter-clash.log", "Advancing biters from position: \n" .. startPosX .. ":" .. startPosY, true)
	local currentPosX = biterGroup.position.x
	local currentPosY = biterGroup.position.y
	local distanceX = math.abs(currentPosX)
	local absY = math.abs(currentPosY)
	local distanceY = math.abs(absY - math.abs(siloPosY))
	--helpers.write_file("biter-clash.log", "Distances: \n" .. distanceX .. ":" .. distanceY, true)
	local closeByRatio = (math.random(10, 100))/100
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
		helpers.write_file("biter-clash.log", "Biters target position was nil, moving straight to the silo! (group: " .. currentPosX .. ":" .. currentPosY .. ")\n", true)	
		pos = {x = 0 + jitterX, y = siloPosY + jitterY}
	end
	--helpers.write_file("biter-clash.log", "Added command to move: " .. currentPosX .. ":" .. currentPosY .. " calculated distance: " .. distanceX .. ":" .. distanceY .. "\n", true)	
    biterGroup.group.set_command({
		type = defines.command.attack_area,
		destination = pos,
		radius = 40,
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
	--helpers.write_file("biter-clash.log", "aiStep took: ", true)
	--helpers.write_file("biter-clash.log", {"", profiler}, true)
	--helpers.write_file("biter-clash.log", "\n", true)
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
	if force == "north"  then	
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
	if force == "north" then
		for _, biter in pairs(storage["northAiBiters"]) do
			biterGroup.add_member(biter)
		end
		storage["northAiBiterGroup"] = biterGroup
	else 
		for _, biter in pairs(storage["southAiBiters"]) do
			biterGroup.add_member(biter)
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
		biterMap["force"] = "north"
		id = biterMap["group"].unique_id
		helpers.write_file("biter-clash.log", "Commandable created with ID: " .. biterMap["group"].unique_id .."\n", true)
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
		biterMap["force"] = "south"
		id = biterMap["group"].unique_id
		helpers.write_file("biter-clash.log", "Commandable created with ID: " .. id .."\n", true)
		storage["activeBiterGroups"][id] = biterMap
		advanceBiters(biterMap)		
	end
end

function nextStep(biterGroup) 
	advanceBiters(biterGroup)
end

function tryReformGroup(biterMap)
	currentSurface = game.surfaces[storage["surfaceName"]]
	local individualBiters = currentSurface.find_enemy_units(biterMap.position, 30, biterMap["opposingForce"])
	if individualBiters ~= nil then
		if #individualBiters ~= 0 then
			pos = currentSurface.find_non_colliding_position("assembling-machine-1", biterMap["position"], 512, 1)
			local biterGroup = currentSurface.create_unit_group({position = pos, force = biterMap["force"]})
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
			id = newBiterMap["group"].unique_id
			storage["activeBiterGroups"][id] = newBiterMap
			helpers.write_file("biter-clash.log", "Commandable created with ID: " .. id .."\n", true)
			helpers.write_file("biter-clash.log", "Stuck biter group reformed at position: " .. newBiterMap["position"].x .. "," .. newBiterMap["position"].y .. "\n", true)
			advanceBiters(newBiterMap)
		end
	end
end

function onAiCommandCompleted(event)
	biterGroup = storage["activeBiterGroups"][event.unit_number]
	--helpers.write_file("biter-clash.log", "Ai command completed for: " .. event.unit_number .. "\n", true)
	if biterGroup ~= nil then
		if biterGroup.group.valid then
			--helpers.write_file("biter-clash.log", "Ai command completed for: " .. event.unit_number .. " with result: " .. event.result .. " at position: " .. biterGroup.position.x .. "," .. biterGroup.position.y .. " engine position: " .. biterGroup.group.position.x .. "," .. biterGroup.group.position.y .."\n", true)
			biterGroup["position"] = biterGroup.group.position
			advanceBiters(biterGroup)
		else
			tryReformGroup(biterGroup)
		end
	end
end
