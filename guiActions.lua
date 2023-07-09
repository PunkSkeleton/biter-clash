require "utils"

function setPermissionsOnTeamJoin(player)
	if settings.global["tournament-mode"].value == true then
		player.gui.top["ready"].visible = true
		player.gui.top["biter-clash"].visible = false
        if not global["gameStarted"] then
			player.gui.top["ready"].visible = true
			game.permissions.get_group("Default").remove_player(player)
			game.permissions.get_group("Players").add_player(player)
		end
    end
end

function joinNorth(player)
	clearInventories(player)
	player.force="north"
	pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0,-740}, 5, 0.1)
	player.teleport(pos, global["surfaceName"])
	setPermissionsOnTeamJoin(player)
	player.gui.center["mapRegenerating"].visible = false
	player.gui.left["guideToggle"].visible = false
end

function joinSouth(player)
	clearInventories(player)
	player.force="south"
	pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0, 760}, 5, 0.1)
	player.teleport(pos, global["surfaceName"])
	setPermissionsOnTeamJoin(player)
	player.gui.center["mapRegenerating"].visible = false
	player.gui.left["guideToggle"].visible = false
end

function spectate(player)
	player.force="spectators"
	pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0,0}, 5, 0.1)
	if pos ~= nil then
		player.teleport(pos, global["surfaceName"])
	end
	player.gui.top["biter-clash"].visible = true
	game.permissions.get_group("Players").remove_player(player)
	game.permissions.get_group("Default").add_player(player)
	player.gui.left["guideToggle"].visible = true
end

function startGame()
	game.forces["north"].technologies["automation"].researched = true
	game.forces["north"].technologies["logistics"].researched = true
	game.forces["north"].technologies["rocket-silo"].researched = true
	game.forces["south"].technologies["automation"].researched = true
	game.forces["south"].technologies["logistics"].researched = true
	game.forces["south"].technologies["rocket-silo"].researched = true
	global["northResearchedString"] = "North completed research:\n"
	global["southResearchedString"] = "South completed research:\n"
	pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0,-740}, 5, 0.1)
	game.forces["north"].set_spawn_position(pos,global["surfaceName"])
	pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0, 760}, 5, 0.1)
	game.forces["south"].set_spawn_position(pos,global["surfaceName"])
	global["gameStarted"] = true
	global["gameStartedTick"] = game.tick
	convertBlueprints(-750, "north", global["northPackchest"])
	convertBlueprints(750, "south", global["southPackchest"])
	if settings.global["tournament-mode"].value == true then
		game.permissions.get_group("Players").set_allows_action(defines.input_action.open_blueprint_library_gui, false)
		game.permissions.get_group("Players").set_allows_action(defines.input_action.import_blueprint_string, false)
		game.permissions.get_group("Players").set_allows_action(defines.input_action.start_walking, true)
		clearAllGhosts()
		clearInventories()
		clearQuickBars()	
		for i, player in pairs(game.connected_players) do
			if player.force ~= "spectators" then
				player.gui.top["biter-clash"].visible = false
				player.gui.top["ready"].visible = false
			else 
				player.gui.top["biter-clash"].visible = true
			end
		end
    end
    for i, player in pairs(game.connected_players) do
    	player.gui.top["gameClock"].visible = true
    end
end

function startingSequence()
	global["countdown"] = 10
end

function teamReady(player, setReady)
	if player.force.name == "north" then
		global["northSideReady"] = setReady
		for i, player in pairs(game.connected_players) do
			if player.force.name == "north" then
				player.gui.top["ready"]["buttonflow2"]["biter-clash-ready"].state = setReady
			end
		end
	else
		global["southSideReady"] = setReady
		for i, player in pairs(game.connected_players) do
			if player.force.name == "south" then
				player.gui.top["ready"]["buttonflow2"]["biter-clash-ready"].state = setReady
			end
		end
	end
	if global["southSideReady"] and global["northSideReady"] then
		startingSequence()
	end
end


