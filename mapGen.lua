require "utils"
require "ai.ai"

function generateStartingArea(size)
	tiles = {}
	for i=-size,size do 
		for j=-size,size do
			table.insert(tiles, {name = "dirt-5",position = {i,j}})
		end
	end
	game.surfaces[storage["surfaceName"]].set_tiles(tiles)
	
	tiles = {}
	i=-size
	for j=-size,size do
		table.insert(tiles, {name = "lab-dark-1",position = {i,j}})
	end
	i=size
	for j=-size,size do
		table.insert(tiles, {name = "lab-dark-1",position = {i,j}})
	end
	j=-size
	for i=-size,size do 
		table.insert(tiles, {name = "lab-dark-1",position = {i,j}})
	end
	j=size
	for i=-size,size do 
		table.insert(tiles, {name = "lab-dark-1",position = {i,j}})
	end
	game.surfaces[storage["surfaceName"]].set_tiles(tiles)
	
end

function generateBiterSpawingArea()
	tiles = {}
	for i=-550,-501 do 
		for j=-550,500 do
			table.insert(tiles, {name = "dirt-5",position = {i,j}})
		end
	end
	for i=501,550 do 
		for j=-550,500 do
			table.insert(tiles, {name = "dirt-5",position = {i,j}})
		end
	end
	for i=-550,550 do 
		for j=-550,-501 do
			table.insert(tiles, {name = "dirt-5",position = {i,j}})
		end
	end
	for i=-550,550 do 
		for j=501, 550 do
			table.insert(tiles, {name = "dirt-5",position = {i,j}})
		end
	end
	game.surfaces[storage["surfaceName"]].set_tiles(tiles)
	
	tiles = {}
	i=-500
	for j=-500,500 do
		table.insert(tiles, {name = "lab-dark-1",position = {i,j}})
	end
	i=500
	for j=-500,500 do
		table.insert(tiles, {name = "lab-dark-1",position = {i,j}})
	end
	j=-500
	for i=-500,500 do 
		table.insert(tiles, {name = "lab-dark-1",position = {i,j}})
	end
	j=500
	for i=-500,500 do 
		table.insert(tiles, {name = "lab-dark-1",position = {i,j}})
	end
	game.surfaces[storage["surfaceName"]].set_tiles(tiles)
	tiles = {}
	for i, currentArea in pairs(biterStagingAreas) do
		table.insert(tiles, {name = "grass-1",position = {currentArea["middleX"],currentArea["middleY"]}})		
	end
	game.surfaces[storage["surfaceName"]].set_tiles(tiles)
end

function clearBiterSpawningArea()
	clearArea(-550,-500,-550,500, false)
	clearArea(500,550,-550,500, false)
	clearArea(-550,550,-550,-500, false)
	clearArea(-550,550, 500, 550, false)
	storage["biterAreaToBeCleared"] = false
end

function generateMapSettings()
	local settings = {}
	settings.width = 1100
	settings.height = 1100
	settings.water = math.random(2, 7) * 0.5
	settings.starting_area = 1
	settings.terrain_segmentation = math.random(1, 6) * 0.5
	settings.cliff_settings = {cliff_elevation_interval = math.random(10, 20), cliff_elevation_0 = math.random(10, 20), richness = math.random(5, 10) * 0.8}
	settings.autoplace_controls = {
		["coal"] = {frequency = math.random(9, 12), size = math.random(5, 14) * 0.1, richness = math.random(2, 8) * 0.06},
		["stone"] = {frequency = math.random(9, 12), size = math.random(3, 10) * 0.1, richness = math.random(2, 8) * 0.06},
		["copper-ore"] = {frequency = math.random(12, 20), size = math.random(4, 12) * 0.1, richness = math.random(2,12) * 0.04},
		["iron-ore"] = {frequency = math.random(12, 20), size = math.random(4, 12) * 0.1, richness = math.random(2,12) * 0.04}, 	
		["uranium-ore"] = {frequency = 2, size = 3, richness = 1},
		["crude-oil"] = {frequency = math.random(18, 36), size = math.random(5, 20) * 0.1, richness = math.random(2, 9) * 0.1},
		["trees"] = {frequency = math.random(6, 32) * 0.05, size = math.random(2, 28) * 0.05, richness = math.random(1, 10) * 0.05},
		["enemy-base"] = {frequency = 0, size = 0, richness = 0}
	}
	settings.peaceful_mode = false
	settings.seed = game.tick
	return settings
end

function generateMap()		
	helpers.write_file("biter-clash.log", "Generate map called, surface name = '" .. storage["surfaceName"] .. "'\n", true)
	if storage["surfaceName"] == nil then
		helpers.write_file("biter-clash.log", "Surface name is nil\n", true)
		storage["surfaceIndex"] = 99
		storage["surfaceName"] = "biterWars" .. storage["surfaceIndex"]
	end
	helpers.write_file("biter-clash.log", "Generate map 2, surface name = '" .. storage["surfaceName"] .. "'\n", true)
	game.create_surface(storage["surfaceName"], generateMapSettings())
	storage["mapGeneratedTick"] = game.tick
	storage["prepareMap"] = true
	storage["biterAreaToBeCleared"] = true
	storage["mapToBeCloned"] = true
	storage["mapToBeCloned2"] = true
end

function reGenerateMap()
	helpers.write_file("biter-clash.log", "Regenerate map called, surface name = '" .. storage["surfaceName"] .. "'\n", true)
	storage["northResearchedString"] = "North completed research:\n"
	storage["southResearchedString"] = "South completed research:\n"
	for i, player in pairs(game.connected_players) do
		player.gui.center["mapRegenerating"].visible = true
		player.gui.center["victory"].visible = false
		player.gui.center["defeat"].visible = false
	end
	resetForces()
	for i, player in pairs(game.connected_players) do
		spectate(player)
		player.teleport({0, 0}, "nauvis")
	end
	game.delete_surface(storage["surfaceName"])
	storage["surfaceIndex"] = storage["surfaceIndex"] + 2
	storage["surfaceName"] = "biterWars" .. storage["surfaceIndex"]
	helpers.write_file("biter-clash.log", "Regenerate map 2, surface name = '" .. storage["surfaceName"] .. "'\n", true)
	generateMap()
	for i, player in pairs(game.connected_players) do
		player.teleport({0, i}, storage["surfaceName"])
		player.gui.top["gameClock"].visible = false
	end
	game.forces["spectators"].chart(storage["surfaceName"],{{-5000, -5000}, {5000, 5000}})
end

function cloneMap()
	storage["newSurfaceIndex"] = storage["surfaceIndex"]+1
	storage["newSurfaceName"] = "biterWars" .. storage["newSurfaceIndex"]
	game.create_surface(storage["newSurfaceName"], generateMapSettings())
	cloneMainArea(200)
	cloneMainArea(-1300)
	storage["mapToBeCloned"] = false
	game.forces["spectators"].chart(storage["newSurfaceName"],{{-550, -200}, {550, 200}})
end

function cloneMainArea(offset)
	game.surfaces[storage["surfaceName"]].clone_area{source_area={{-550,-550},{550,550}}, 
		destination_area={{-550,offset},{550,1100+offset}},
		destination_surface=storage["newSurfaceName"], 
 		clone_tiles=true,
 		clone_entities=true,
 		clone_decoratives=true, 
 		expand_map=true,
 		create_build_effect_smoke=false}
end

function generateRiver()
	tiles = {}
	for i=-550,550 do
		for j=-199,199 do
			table.insert(tiles, {name = "deepwater",position = {i,j}})
		end
	end
	game.surfaces[storage["newSurfaceName"]].set_tiles(tiles)
end

function generateWaterWells()
	tiles = {}
	table.insert(tiles, {name = "deepwater",position = {2,-755}})
	table.insert(tiles, {name = "deepwater",position = {2,745}})
	game.surfaces[storage["newSurfaceName"]].set_tiles(tiles)
end

function generateIsland()
	tiles = {}
	for i=-20,20 do
		for j=-20,20 do
			table.insert(tiles, {name = "grass-4",position = {i,j}})
		end
	end
	game.surfaces[storage["newSurfaceName"]].set_tiles(tiles)
end

function fillStarterChest(chest)
	chest.insert({name="transport-belt", count=500})
	chest.insert({name="inserter", count=200})
	chest.insert({name="assembling-machine-1", count=50})
	chest.insert({name="lab", count=10})
	chest.insert({name="pipe", count=20})
	chest.insert({name="pipe-to-ground", count=4})
	chest.insert({name="steam-engine", count=10})
	chest.insert({name="boiler", count=5})
	chest.insert({name="small-electric-pole", count=200})
	chest.insert({name="underground-belt", count=20})
	chest.insert({name="splitter", count=10})
	chest.insert({name="burner-inserter", count=5})
	chest.insert({name="iron-chest", count=30})
	chest.insert({name="long-handed-inserter", count=30})
	chest.insert({name="iron-plate", count=600})
	chest.insert({name="copper-plate", count=300})
	chest.insert({name="iron-gear-wheel", count=300})
	chest.insert({name="electronic-circuit", count=300})
	chest.insert({name="wood", count=100})
	chest.insert({name="electric-mining-drill", count=50})
end

function spawnNorthStart()
	clearArea(-50,50,-800,-700, true)
	storage["northPackchest"] = game.surfaces[storage["surfaceName"]].create_entity({name = "steel-chest", position = {x=0, y=-699}, force =  "north"})
	fillStarterChest(storage["northPackchest"])
	northRocketSilo = game.surfaces[storage["surfaceName"]].create_entity({name = "rocket-silo", position = {x=0, y=-750}, force =  "north"})
	storage["northSiloId"], _, _ = script.register_on_object_destroyed(northRocketSilo)
	storage["northIronChest1"] = game.surfaces[storage["surfaceName"]].create_entity({name = "steel-chest", position = {x=-4, y=-745}, force =  "north"})
	storage["northIronChest2"] = game.surfaces[storage["surfaceName"]].create_entity({name = "steel-chest", position = {x=-2, y=-745}, force =  "north"})
	storage["northCopperChest"] = game.surfaces[storage["surfaceName"]].create_entity({name = "steel-chest", position = {x=-0, y=-745}, force =  "north"})
	storage["northStoneChest"] = game.surfaces[storage["surfaceName"]].create_entity({name = "steel-chest", position = {x=2, y=-745}, force =  "north"})
	storage["northCoalChest"] = game.surfaces[storage["surfaceName"]].create_entity({name = "steel-chest", position = {x=4, y=-755}, force =  "north"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "offshore-pump", position = {x=2, y=-756}, force =  "north", direction = defines.direction.south})
	northloaderIron1 = game.surfaces[storage["surfaceName"]].create_entity({name = "loader-1x1", position = {x=-4, y=-744}, force =  "north", direction = defines.direction.south})
	northloaderIron1.loader_type = "output"
	northloaderIron1.set_filter(1, "iron-plate")
	northloaderIron2 = game.surfaces[storage["surfaceName"]].create_entity({name = "loader-1x1", position = {x=-2, y=-744}, force =  "north", direction = defines.direction.south})
	northloaderIron2.loader_type = "output"
	northloaderIron2.set_filter(1, "iron-plate")
	northloaderCopper = game.surfaces[storage["surfaceName"]].create_entity({name = "loader-1x1", position = {x=0, y=-744}, force =  "north", direction = defines.direction.south})
	northloaderCopper.loader_type = "output"
	northloaderCopper.set_filter(1, "copper-plate")
	northloaderStone = game.surfaces[storage["surfaceName"]].create_entity({name = "loader-1x1", position = {x=2, y=-744}, force =  "north", direction = defines.direction.south})
	northloaderStone.loader_type = "output"
	northloaderStone.set_filter(1, "stone")
	northloaderCoal = game.surfaces[storage["surfaceName"]].create_entity({name = "loader-1x1", position = {x=4, y=-756}, force =  "north", direction = defines.direction.north})
	northloaderCoal.loader_type = "output"
	northloaderCoal.set_filter(1, "coal")
	storage["northCoalChest"].insert({name="coal", count=10})
end

function spawnSouthStart()
	clearArea(-50,50,700,800, true)
	storage["southPackchest"] = game.surfaces[storage["surfaceName"]].create_entity({name = "steel-chest", position = {x=0, y=801}, force =  "south"})
	fillStarterChest(storage["southPackchest"])
	southRocketSilo = game.surfaces[storage["surfaceName"]].create_entity({name = "rocket-silo", position = {x=0, y=750}, force =  "south"})
	storage["southSiloId"], _, _ = script.register_on_object_destroyed(southRocketSilo)
	storage["southIronChest1"] = game.surfaces[storage["surfaceName"]].create_entity({name = "steel-chest", position = {x=-4, y=755}, force =  "south"})
	storage["southIronChest2"] = game.surfaces[storage["surfaceName"]].create_entity({name = "steel-chest", position = {x=-2, y=755}, force =  "south"})
	storage["southCopperChest"] = game.surfaces[storage["surfaceName"]].create_entity({name = "steel-chest", position = {x=-0, y=755}, force =  "south"})
	storage["southStoneChest"] = game.surfaces[storage["surfaceName"]].create_entity({name = "steel-chest", position = {x=2, y=755}, force =  "south"})
	storage["southCoalChest"] = game.surfaces[storage["surfaceName"]].create_entity({name = "steel-chest", position = {x=4, y=745}, force =  "south"})
	game.surfaces[storage["surfaceName"]].create_entity({name = "offshore-pump", position = {x=2, y=744}, force =  "south", direction = defines.direction.south})
	southloaderIron1 = game.surfaces[storage["surfaceName"]].create_entity({name = "loader-1x1", position = {x=-4, y=756}, force =  "south", direction = defines.direction.south})
	southloaderIron1.loader_type = "output"
	southloaderIron1.set_filter(1, "iron-plate")
	southloaderIron2 = game.surfaces[storage["surfaceName"]].create_entity({name = "loader-1x1", position = {x=-2, y=756}, force =  "south", direction = defines.direction.south})
	southloaderIron2.loader_type = "output"
	southloaderIron2.set_filter(1, "iron-plate")
	southloaderCopper = game.surfaces[storage["surfaceName"]].create_entity({name = "loader-1x1", position = {x=0, y=756}, force =  "south", direction = defines.direction.south})
	southloaderCopper.loader_type = "output"
	southloaderCopper.set_filter(1, "copper-plate")
	southloaderStone = game.surfaces[storage["surfaceName"]].create_entity({name = "loader-1x1", position = {x=2, y=756}, force =  "south", direction = defines.direction.south})
	southloaderStone.loader_type = "output"
	southloaderStone.set_filter(1, "stone")
	southloaderCoal = game.surfaces[storage["surfaceName"]].create_entity({name = "loader-1x1", position = {x=4, y=744}, force =  "south", direction = defines.direction.north})
	southloaderCoal.loader_type = "output"
	southloaderCoal.set_filter(1, "coal")
end

function finishGeneration()
	game.delete_surface(storage["surfaceName"])
	storage["surfaceName"] = storage["newSurfaceName"]
	storage["surfaceIndex"] = storage["newSurfaceIndex"]
	game.forces["spectators"].chart(storage["surfaceName"],{{-5000, -5000}, {5000, 5000}})
	game.forces["north"].chart(storage["surfaceName"],{{-550, -1300}, {550, 0}})
	game.forces["south"].chart(storage["surfaceName"],{{-550, 0}, {550, 1300}})
	spawnNorthStart()
	spawnSouthStart()
	pos = game.surfaces[storage["surfaceName"]].find_non_colliding_position("character", {0,-740}, 5, 0.1)
	game.forces["north"].set_spawn_position(pos,storage["surfaceName"])
	helpers.write_file("biter-clash.log", "spawn position north: " .. pos.y, true)
	pos = game.surfaces[storage["surfaceName"]].find_non_colliding_position("character", {0, 760}, 5, 0.1)
	game.forces["south"].set_spawn_position(pos,storage["surfaceName"])
	helpers.write_file("biter-clash.log", "spawn position south: " .. pos.y, true)
end

function finishMapGeneration()
	for i, player in pairs(game.connected_players) do
		pos = game.surfaces[storage["surfaceName"]].find_non_colliding_position("character", {0, 0}, 5, 0.1)
		player.teleport(pos, storage["surfaceName"])
	end
	generateRiver()
	generateIsland()
	generateWaterWells()
	finishGeneration()
	storage["mapToBeCloned2"] = false
	game.forces["north"].chart(storage["surfaceName"],{{-5000, -5000}, {5000, 5000}})
	game.forces["south"].chart(storage["surfaceName"],{{-5000, -5000}, {5000, 5000}})
	for i, player in pairs(game.connected_players) do
		pos = game.surfaces[storage["surfaceName"]].find_non_colliding_position("character", {0, 0}, 5, 0.1)
		player.teleport(pos, storage["surfaceName"])
		player.gui.center["mapRegenerating"].visible = false
	end
end
	
