require "utils"

function setPermissionsOnTeamJoin(player)
	if settings.global["tournament-mode"].value == true then
		player.gui.top["biter-clash"].visible = false
        if not global["gameStarted"] then
			player.gui.top["ready"].visible = true
		end
		game.permissions.get_group("Default").remove_player(player)
		game.permissions.get_group("Players").add_player(player)
		player.gui.left["team-join"].visible = false
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
	game.print(player.name .. " has joined team north!")
end

function joinSouth(player)
	clearInventories(player)
	player.force="south"
	pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0, 760}, 5, 0.1)
	player.teleport(pos, global["surfaceName"])
	setPermissionsOnTeamJoin(player)
	player.gui.center["mapRegenerating"].visible = false
	player.gui.left["guideToggle"].visible = false
	game.print(player.name .. " has joined team south!")
end

function spectate(player)
	game.print(player.name .. " has left team " .. player.force.name .. "!")
	player.force="spectators"
	pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0,0}, 5, 0.1)
	if pos ~= nil then
		player.teleport(pos, global["surfaceName"])
	end
	player.gui.top["biter-clash"].visible = true
	game.permissions.get_group("Players").remove_player(player)
	game.permissions.get_group("Default").add_player(player)
	player.gui.left["guideToggle"].visible = true
	player.gui.left["team-join"].visible = true
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
		clearAllInventories()
		clearQuickBars()	
		for i, player in pairs(game.connected_players) do
			if player.force.name ~= "spectators" then
				player.gui.top["biter-clash"].visible = false
				player.gui.left["team-join"].visible = false
				player.gui.top["ready"].visible = false
			else 
				player.gui.top["biter-clash"].visible = true
				if global["lockTeams"] then
					player.gui.left["team-join"].visible = false
				end
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
	local readyString = "not ready"
	if setReady then
		readyString = "ready"
	end
	game.print(player.name .. " has set team " .. player.force.name .. " to " .. readyString .. "!")
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
	local northReadyString = "is not"
	local southReadyString = "is not"
	if global["northSideReady"] then
		northReadyString = "is"
	end
	if global["southSideReady"] then
		southReadyString = "is"
	end
	game.print("Currently north " .. northReadyString .. " ready and south " .. southReadyString .. " ready!")
	if global["southSideReady"] and global["northSideReady"] then
		startingSequence()
	end
end

function lockTeams(player, lockState)
	if global["gameStarted"] == false then
		global["lockTeams"] = lockState
		for i, player in pairs(game.connected_players) do
			player.gui.left["team-join"]["teamJoinButtonflow"]["lock-teams"].state = lockState
		end
	else
		player.gui.left["team-join"]["teamJoinButtonflow"]["lock-teams"].state = global["lockTeams"]
	end
end

