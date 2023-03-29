require "biterStagingAreas"

function selectBitersInner(area, force, offset) 
	local middleX = area["middleX"]
	local middleY = area["middleY"] + offset
	local position = {x = middleX, y = middleY}
	if force == "south" then
		opposingForce = "north"
		--game.write_file("biter-clash.log", "a\n", true)
	else
		opposingForce = "south"
		--game.write_file("biter-clash.log", "b\n", true)
	end
	--game.write_file("biter-clash.log", "c\n", true)
	game.write_file("biter-clash.log", "Selecting biters!" .. " middle: " .. middleX .. ":" .. middleY .. "force: " .. force .. "\n", true)
 	currentSurface = game.surfaces[global["surfaceName"]]
	local individualBiters = currentSurface.find_enemy_units(position, 36, opposingForce)
	if individualBiters == nil then
		--game.write_file("biter-clash.log", "individualBiters is nil!\n", true)
		return nil
	end
	if #individualBiters == 0 then
		--game.write_file("biter-clash.log", "individualBiters size is zero!\n", true)
		return nil
	end
	return individualBiters
end
	

function advanceBiters(biterGroup, forceName, startPosX, startPosY)
	if forceName == "north" then
		siloPosY = 750
	else
		siloPosY = -750
	end
	game.write_file("biter-clash.log", "Advancing biters from position: \n" .. startPosX .. ":" .. startPosY, true)
	local currentPosX = startPosX
	local currentPosY = startPosY
	local distanceX = math.abs(currentPosX)
	local absY = math.abs(currentPosY)
	local distanceY = math.abs(absY - math.abs(siloPosY))
	game.write_file("biter-clash.log", "Distances: \n" .. distanceX .. ":" .. distanceY, true)
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
	currentSurface = game.surfaces[global["surfaceName"]]
	pos = currentSurface.find_non_colliding_position("assembling-machine-1", position, 128, 1)
	game.write_file("biter-clash.log", "Added command to move: " .. currentPosX .. ":" .. currentPosY .. " calculated distance: " .. distanceX .. ":" .. distanceY .. "\n", true)	
    biterGroup.set_command({
		type = defines.command.attack_area,
		destination = pos,
		radius = 32,
		distraction = defines.distraction.by_enemy
	})
end

function aiRootStep()
	profiler = game.create_profiler(true)
	profiler.restart()
	local currentPointer = global["biterStagingAreaPointer"]
	currentPointer = currentPointer + 1
	if currentPointer > #biterStagingAreas then
		currentPointer = 1
	end
	-- 10% chance of attack happening
	local randomizer = math.random(1,10)
	if (randomizer == 1) then
		global["aiRootActive"] = true
	end
	global["biterStagingAreaPointer"] = currentPointer
	profiler.stop()
	game.write_file("biter-clash.log", "aiStep took: ", true)
	game.write_file("biter-clash.log", {"", profiler}, true)
	game.write_file("biter-clash.log", "\n", true)
	profiler.reset()
end

function selectBiters(force)
	local currentArea = biterStagingAreas[global["biterStagingAreaPointer"]]
	if force == "north" then
		offset = 750
		global["northAiBiters"] = selectBitersInner(currentArea, "north", offset)
	else 
		offset = -750
		global["southAiBiters"] = selectBitersInner(currentArea, "south", offset)
	end
end

function formBiterGroup(force)
	offset = 0
	if force == "north"  then	
		offset = 750
		if global["northAiBiters"] == nil then
			return
		end
	else
		offset = -750
		if global["southAiBiters"] == nil then
			return
		end
	end
	local area = biterStagingAreas[global["biterStagingAreaPointer"]]
	local middleX = area["middleX"]
	local middleY = area["middleY"] + offset
	local position = {x = middleX, y = middleY}
	currentSurface = game.surfaces[global["surfaceName"]]
	pos = currentSurface.find_non_colliding_position("assembling-machine-1", position, 512, 1)
	local biterGroup = currentSurface.create_unit_group({position = pos, force = force})
	if force == "north" then
		for _, biter in pairs(global["northAiBiters"]) do
			biterGroup.add_member(biter)
		end
		global["northAiBiterGroup"] = biterGroup
	else 
		for _, biter in pairs(global["southAiBiters"]) do
			biterGroup.add_member(biter)
		end
		global["southAiBiterGroup"] = biterGroup
	end
end

function firstCommand() 
	if global["northAiBiterGroup"] ~= nil then
		local currentArea = biterStagingAreas[global["biterStagingAreaPointer"]]
		table.insert(global["activeBiterGroups"], global["northAiBiterGroup"])
		advanceBiters(global["northAiBiterGroup"], "north", currentArea["middleX"], currentArea["middleY"] + 750)
	end
	if global["southAiBiterGroup"] ~= nil then
		local currentArea = biterStagingAreas[global["biterStagingAreaPointer"]]
		table.insert(global["activeBiterGroups"], global["southAiBiterGroup"])
		advanceBiters(global["southAiBiterGroup"], "south", currentArea["middleX"], currentArea["middleY"] - 750)		
	end
end

function nextStep(biterGroup) 
	advanceBiters(biterGroup, biterGroup.force.name, biterGroup.position.x, biterGroup.position.y)
end
