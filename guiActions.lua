require "utils"

function setPermissionsOnTeamJoin(player)
	if settings.global["tournament-mode"].value == true then
		player.gui.top["biter-clash"].visible = false
        if not storage["gameStarted"] then
			player.gui.top["ready"].visible = true
		end
		game.permissions.get_group("Default").remove_player(player)
		game.permissions.get_group("Players").add_player(player)
		player.gui.left["team-join"].visible = false
    end
end

function joinNorth(player)
	clearInventories(player)
	if storage["gameStarted"] ~= true then
		addDefaultBlueprints(player)
		player.gui.center["quickGuide"].visible = true
	end
	player.force="north"
	pos = game.surfaces[storage["surfaceName"]].find_non_colliding_position("character", {0,-740}, 5, 0.1)
	player.teleport(pos, storage["surfaceName"])
	setPermissionsOnTeamJoin(player)
	player.gui.center["mapRegenerating"].visible = false
	player.gui.left["guideToggle"].visible = false
	game.print(player.name .. " has joined team north!")
end

function joinSouth(player)
	clearInventories(player)
	if storage["gameStarted"] ~= true then
		addDefaultBlueprints(player)
		player.gui.center["quickGuide"].visible = true
	end
	player.force="south"
	pos = game.surfaces[storage["surfaceName"]].find_non_colliding_position("character", {0, 760}, 5, 0.1)
	player.teleport(pos, storage["surfaceName"])
	setPermissionsOnTeamJoin(player)
	player.gui.center["mapRegenerating"].visible = false
	player.gui.left["guideToggle"].visible = false
	game.print(player.name .. " has joined team south!")
end

function spectate(player)
	game.print(player.name .. " has left team " .. player.force.name .. "!")
	player.force="spectators"
	pos = game.surfaces[storage["surfaceName"]].find_non_colliding_position("character", {0,0}, 5, 0.1)
	if pos ~= nil then
		player.teleport(pos, storage["surfaceName"])
	end
	player.gui.top["biter-clash"].visible = true
	game.permissions.get_group("Players").remove_player(player)
	game.permissions.get_group("Default").add_player(player)
	player.gui.left["guideToggle"].visible = true
	player.gui.left["team-join"].visible = true
end

function startGame()
	game.forces["north"].technologies["automation"].researched = true
	game.forces["north"].technologies["electronics"].researched = true
	game.forces["north"].technologies["steam-power"].researched = true
	game.forces["north"].technologies["automation-science-pack"].researched = true
	game.forces["north"].technologies["radar"].researched = true
	game.forces["north"].technologies["electric-mining-drill"].researched = true
	game.forces["north"].technologies["repair-pack"].researched = true
	game.forces["north"].technologies["oil-processing"].researched = true
	game.forces["north"].technologies["logistics"].researched = true
	game.forces["north"].technologies["rocket-silo"].researched = true
	game.forces["south"].technologies["automation"].researched = true
	game.forces["south"].technologies["electronics"].researched = true
	game.forces["south"].technologies["steam-power"].researched = true
	game.forces["south"].technologies["automation-science-pack"].researched = true
	game.forces["south"].technologies["radar"].researched = true
	game.forces["south"].technologies["electric-mining-drill"].researched = true
	game.forces["south"].technologies["repair-pack"].researched = true
	game.forces["south"].technologies["oil-processing"].researched = true
	game.forces["south"].technologies["logistics"].researched = true
	game.forces["south"].technologies["rocket-silo"].researched = true
	storage["northResearchedString"] = "North completed research:\n"
	storage["southResearchedString"] = "South completed research:\n"
	pos = game.surfaces[storage["surfaceName"]].find_non_colliding_position("character", {0,-740}, 5, 0.1)
	game.forces["north"].set_spawn_position(pos,storage["surfaceName"])
	pos = game.surfaces[storage["surfaceName"]].find_non_colliding_position("character", {0, 760}, 5, 0.1)
	game.forces["south"].set_spawn_position(pos,storage["surfaceName"])
	storage["gameStarted"] = true
	storage["gameStartedTick"] = game.tick
	convertBlueprints(-750, "north", storage["northPackchest"])
	convertBlueprints(750, "south", storage["southPackchest"])
	if settings.global["tournament-mode"].value == true then
		game.permissions.get_group("Players").set_allows_action(defines.input_action.open_blueprint_library_gui, false)
		game.permissions.get_group("Players").set_allows_action(defines.input_action.import_blueprint_string, false)
		game.permissions.get_group("Players").set_allows_action(defines.input_action.start_walking, true)
		clearAllGhosts()
		for i, player in pairs(game.connected_players) do
			if player.force.name ~= "spectators" then
				player.gui.top["biter-clash"].visible = false
				player.gui.left["team-join"].visible = false
				player.gui.top["ready"].visible = false
			else 
				player.gui.top["biter-clash"].visible = true
				if storage["lockTeams"] then
					player.gui.left["team-join"].visible = false
				end
			end
		end
    end
    clearAllInventories()
	clearQuickBars()
    for i, player in pairs(game.connected_players) do
    	player.gui.top["gameClock"].visible = true
    	player.gui.center["quickGuide"].visible = false
    	fillStarterInventory(player)
    end
end

function startingSequence()
	storage["countdown"] = 10
end

function teamReady(player, setReady)
	local readyString = "not ready"
	if setReady then
		readyString = "ready"
	end
	game.print(player.name .. " has set team " .. player.force.name .. " to " .. readyString .. "!")
	if player.force.name == "north" then
		storage["northSideReady"] = setReady
		for i, player in pairs(game.connected_players) do
			if player.force.name == "north" then
				player.gui.top["ready"]["buttonflow2"]["biter-clash-ready"].state = setReady
			end
		end
	else
		storage["southSideReady"] = setReady
		for i, player in pairs(game.connected_players) do
			if player.force.name == "south" then
				player.gui.top["ready"]["buttonflow2"]["biter-clash-ready"].state = setReady
			end
		end
	end
	local northReadyString = "is not"
	local southReadyString = "is not"
	if storage["northSideReady"] then
		northReadyString = "is"
	end
	if storage["southSideReady"] then
		southReadyString = "is"
	end
	game.print("Currently north " .. northReadyString .. " ready and south " .. southReadyString .. " ready!")
	if storage["southSideReady"] and storage["northSideReady"] then
		startingSequence()
	end
end

function lockTeams(player, lockState)
	if storage["gameStarted"] == false then
		storage["lockTeams"] = lockState
		for i, player in pairs(game.connected_players) do
			player.gui.left["team-join"]["teamJoinButtonflow"]["lock-teams"].state = lockState
		end
	else
		player.gui.left["team-join"]["teamJoinButtonflow"]["lock-teams"].state = storage["lockTeams"]
	end
end

