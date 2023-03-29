require "gui"

function pregame()
	clearArea(-50,50,-50,50, false)
	generateStartingArea(50)
	generateBiterSpawingArea()
end

function initPlayer(player)
	-- if player is not on current surface or is from the old game then the player joins for the first time so has not been initialized 
	currentSurface = game.surfaces[global["surfaceName"]]
	if player.surface.name ~= currentSurface.name then
		pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0, 0}, 5, 0.1)
		if pos == nil then
			pos = {0,0}
		end
		player.teleport(pos, global["surfaceName"])
		player.force="spectators"
		createGui(player)
		player.gui.top["biter-clash"].visible = true
	end
end

function initHost()
	for _, entity in pairs(game.surfaces["nauvis"].find_entities({{-5, -5}, {5, 5}})) do
		if (entity.name == "character") then
			initPlayer(entity.player)
			break
		end
	end
end

function onPlayerJoinedGame(event)
	local player = game.players[event.player_index]
	initPlayer(player)
end

function showCountdown(second)
	for _, player in pairs(game.connected_players) do
		if player.gui.center["countdown"] then
			player.gui.center["countdown"].destroy()
		end
		if second > 0 then
			player.gui.center.add{name = "countdown", type = "sprite", sprite = "bw-" .. second}
		end
	end	
end

function onInit()
	remote.call("freeplay", "set_disable_crashsite", true)
	remote.call("freeplay", "set_skip_intro", true)
end

function onGameStart()
	generateMapGui = "generateMapGui"
	game.create_force("spectators")
	game.create_force("north")
	game.create_force("south")
	game.permissions.create_group("Players")
	game.permissions.get_group("Players").set_allows_action(defines.input_action.start_walking, false)
	game.forces["north"].research_queue_enabled = true
	game.forces["south"].research_queue_enabled = true
	game.map_settings.enemy_expansion.enabled = false
	game.map_settings.pollution.enabled = true
	generateMap()
end
