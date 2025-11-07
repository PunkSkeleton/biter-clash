require "utils"

function spawnTurret(pos)
	local turret = game.surfaces[storage["surfaceName"]].create_entity({name = "gun-turret", position = pos, force =  "south"})
	turret.insert({name="piercing-rounds-magazine", count=50})
	posx = pos.x
	posy = pos.y
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx + 1, posy+1}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx + 1, posy}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx + 1, posy-1}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx + 1, posy-2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 2, posy+1}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 2, posy}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 2, posy-1}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 2, posy-2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx, posy-2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx, posy+1}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx-1, posy+1}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx-1, posy-2}, force =  "south"})
	storage["aiIncome"] = storage["aiIncome"] + 1
	script.register_on_object_destroyed(turret)
end

function spawnTurretNest(pos)
	local posx = pos.x
	local posy = pos.y
	local turret = game.surfaces[storage["surfaceName"]].create_entity({name = "gun-turret", position = {x = posx+1, y = posy+1}, force =  "south"})
	script.register_on_object_destroyed(turret)
	turret.insert({name="piercing-rounds-magazine", count=50})
	local turret = game.surfaces[storage["surfaceName"]].create_entity({name = "gun-turret", position = {x = posx+1, y = posy-1}, force =  "south"})
	script.register_on_object_destroyed(turret)
	turret.insert({name="piercing-rounds-magazine", count=50})
	local turret = game.surfaces[storage["surfaceName"]].create_entity({name = "gun-turret", position = {x = posx-1, y = posy+1}, force =  "south"})
	script.register_on_object_destroyed(turret)
	turret.insert({name="piercing-rounds-magazine", count=50})
	local turret = game.surfaces[storage["surfaceName"]].create_entity({name = "gun-turret", position = {x = posx-1, y = posy-1}, force =  "south"})
	script.register_on_object_destroyed(turret)
	turret.insert({name="piercing-rounds-magazine", count=50})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx + 2, posy + 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx + 1, posy + 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx, posy + 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 1, posy + 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 2, posy + 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 3, posy + 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx + 2, posy - 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx + 1, posy - 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx, posy - 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 1, posy - 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 2, posy - 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 3, posy - 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx + 2, posy + 1}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx + 2, posy}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx + 2, posy - 1}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx + 2, posy - 2}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 3, posy + 1}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 3, posy}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 3, posy - 1}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "stone-wall", position = {posx - 3, posy - 2}, force =  "south"})
	storage["aiIncome"] = storage["aiIncome"] + 4
	
end

function randomTurret()	
	local rand = math.random(0,4000)
	if rand < storage["difficulty"] then
		xpos = math.random(-50,50)
		ypos = math.random(700,800)
		currentSurface = game.surfaces[storage["surfaceName"]]
		pos = currentSurface.find_non_colliding_position("rocket-silo", {x = xpos, y = ypos}, 512, 1)
		spawnTurretNest(pos)
	end
end

function placeNest(nestName)	
	--helpers.write_file("biter-clash.log", game.tick .. ": trying to place ai nest: '" .. nestName .. "'\n", true)
	stagingAreaNumber = math.random(1, #biterStagingAreas) 
	stagingArea = biterStagingAreas[stagingAreaNumber]
	xpos = stagingArea["middleX"]
	ypos = stagingArea["middleY"] - 750
	currentSurface = game.surfaces[storage["surfaceName"]]
	pos = currentSurface.find_non_colliding_position(nestName, {x = xpos, y = ypos}, 512, 1)
	currentSurface.create_entity({name = nestName, position = pos, force =  "southBiters"})
end

function income()
	storage["aiMoney"] = storage["aiMoney"] + storage["aiIncome"]
	--helpers.write_file("biter-clash.log", game.tick .. ": ai money: " .. storage["aiMoney"] .. "\n", true)
end

function setTarget()
	local rand = math.random(0,storage["aiMaxRandom"])
	if rand < 10 then
		local pointer = storage["weaponSpeedResearchPointer"]
		if pointer == 8 then
			setTarget()
		else 
			storage["weaponSpeedResearchPointer"] = storage["weaponSpeedResearchPointer"] + 1
			storage["aiSpendingTarget"] = storage["weaponSpeedResearch"][pointer]
			storage["aiSpendingCost"] = 625 * storage["weaponSpeedResearchPointer"] * storage["weaponSpeedResearchPointer"] * storage["weaponSpeedResearchPointer"]
		end
	elseif rand < 20 then
		local pointer = storage["weaponDamageResearchPointer"]
		if pointer == 8 then
			setTarget()
		else 
			storage["weaponDamageResearchPointer"] = storage["weaponDamageResearchPointer"] + 1
			storage["aiSpendingTarget"] = storage["weaponDamageResearch"][pointer]
			storage["aiSpendingCost"] = 1000 * storage["weaponDamageResearchPointer"] * storage["weaponDamageResearchPointer"] * storage["weaponDamageResearchPointer"]
		end
	elseif rand < 30 then
		local pointer = storage["biterResearchPointer"]
		if pointer == 9 then
			setTarget()
		else 
			storage["biterResearchPointer"] = storage["biterResearchPointer"] + 1
			storage["aiSpendingTarget"] = storage["biterResearch"][pointer]
			storage["aiSpendingCost"] = 750 * storage["biterResearchPointer"] * storage["biterResearchPointer"] * storage["biterResearchPointer"]
			storage["researchingBiters"] = true
		end
	elseif rand < 40 then
		local pointer = storage["spitterResearchPointer"]
		if pointer == 9 then
			setTarget()
		else 
			storage["spitterResearchPointer"] = storage["spitterResearchPointer"] + 1
			storage["aiSpendingTarget"] = storage["spitterResearch"][pointer]
			storage["aiSpendingCost"] = 750 * storage["spitterResearchPointer"] * storage["spitterResearchPointer"] * storage["spitterResearchPointer"]
			storage["researchingSpitters"] = true
		end
	elseif rand < 340 then
		if storage["bitersResearched"] then
			storage["aiSpendingTarget"] = "biterNest"
			storage["aiSpendingCost"] = 350 * storage["biterResearchPointer"]
		else 
			storage["aiSpendingTarget"] = "spitterNest"
			storage["aiSpendingCost"] = 250 * storage["spitterResearchPointer"]
		end
	elseif rand < 640 then
		storage["aiSpendingTarget"] = "spitterNest"
		storage["aiSpendingCost"] = 250 * storage["spitterResearchPointer"]
	end
	--helpers.write_file("biter-clash.log", game.tick .. ": ai target set to: " .. storage["aiSpendingTarget"] .. "\n", true)
end

function completeAiResearch()
	local technologyName = storage["aiSpendingTarget"]
	game.forces["south"].technologies[technologyName].researched = true
	--helpers.write_file("biter-clash.log", game.tick .. ": ai researched " .. technologyName .. "\n", true)
	if storage["researchingBiters"] then
		storage["researchingBiters"] = false
		local nestPointer = storage["biterResearchPointer"] - 1
		local newNestName = storage["biterNestMap"][nestPointer]
		--helpers.write_file("biter-clash.log", game.tick .. ": new nest name: '" .. technologyName .. "'\n", true)
		storage["currentBiterNest"] = newNestName
		if storage["bitersResearched"] == false then
			storage["bitersResearched"] = true
			storage["aiMaxRandom"] = storage["aiMaxRandom"] + 300
		end		
	elseif storage["researchingSpitters"] then
		storage["researchingSpitters"]  = false
		local nestPointer = storage["spitterResearchPointer"] - 1
		local newNestName = storage["spitterNestMap"][nestPointer]
		--helpers.write_file("biter-clash.log", game.tick .. ": new nest name: '" .. technologyName .. "'\n", true)
		storage["currentSpitterNest"] = newNestName
		if storage["spittersResearched"] == false then
			storage["spittersResearched"] = true
			storage["aiMaxRandom"] = storage["aiMaxRandom"] + 300
		end		
	end 
end

function spending()
	if storage["aiMoney"] >= storage["aiSpendingCost"] then
		--helpers.write_file("biter-clash.log", game.tick .. ": ai built " .. storage["aiSpendingTarget"] .. " for: " .. storage["aiSpendingCost"] .. "\n", true)
		storage["aiMoney"] = storage["aiMoney"] - storage["aiSpendingCost"]
		storage["aiSpendingCost"] = 0
		if storage["aiSpendingTarget"] == "biterNest" then
			placeNest(storage["currentBiterNest"])
		elseif storage["aiSpendingTarget"] == "spitterNest" then
			placeNest(storage["currentSpitterNest"])
		else
			completeAiResearch()
		end
	end
end

function singlePlayer()
	randomTurret()
	income()
	if storage["aiSpendingCost"] == 0 then
		setTarget()
	end
	spending()
end