require "mapGen"
require "guiActions"

function createGui(player)
	if player.gui.top["biter-clash"] then
		return 
	end
	local frame = player.gui.top.add{
		type = "frame", name = "biter-clash", caption = {"biter-clash.frame-heading"}, direction = "vertical", style = "biter-clash_frame"}
	frame.style.width = 180
	
	local buttoncontainer = frame.add{ type = "flow", name = "buttonflow", direction = "vertical"}
	
	buttoncontainer.add{ type = "button", name = "biter-clash-regenerate-map", style = "rounded_button", caption = {"biter-clash.regenerate-map"} }
	buttoncontainer.style.minimal_width = 100
	buttoncontainer.style.horizontally_stretchable = true
	
	buttoncontainer.add{ type = "button", name = "biter-clash-join-north", style = "rounded_button", caption = {"biter-clash.join-north"} }
	buttoncontainer.style.minimal_width = 50
	buttoncontainer.style.horizontally_stretchable = true
	
	buttoncontainer.add{ type = "button", name = "biter-clash-join-south", style = "rounded_button", caption = {"biter-clash.join-south"} }
	buttoncontainer.style.minimal_width = 50
	buttoncontainer.style.horizontally_stretchable = true
	
	buttoncontainer.add{ type = "button", name = "biter-clash-spectate", style = "rounded_button", caption = {"biter-clash.spectate"} }
	buttoncontainer.style.minimal_width = 50
	buttoncontainer.style.horizontally_stretchable = true
	
	buttoncontainer.add{ type = "button", name = "biter-clash-start-game", style = "rounded_button", caption = {"biter-clash.start-game"} }
	buttoncontainer.style.minimal_width = 50
	buttoncontainer.style.horizontally_stretchable = true
	
	local frame2 = player.gui.top.add{
		type = "frame", name = "ready", caption = {"ready.frame-heading"}, direction = "vertical", style = "biter-clash_frame"}
	frame.style.width = 250
	
	local buttoncontainer2 = frame2.add{ type = "flow", name = "buttonflow2", direction = "vertical"}
	
	buttoncontainer2.add{ type = "checkbox", name = "biter-clash-ready", caption = {"biter-clash.ready"}, state = false }
	buttoncontainer2.style.minimal_width = 100
	buttoncontainer2.style.horizontally_stretchable = true
	
	player.gui.top["ready"].visible = false
	
	buttoncontainer2.add{ type = "button", name = "biter-clash-exit-team", style = "rounded_button", caption = {"biter-clash.exit-team"} }
	buttoncontainer2.style.minimal_width = 100
	buttoncontainer2.style.horizontally_stretchable = true
	
	player.gui.top["ready"].visible = false
	
	local gameClock = player.gui.top.add{type="frame", name="gameClock"}
    gameClock.style.padding = {0, 6, 0, 6}
    gameClock.style.width = 80
    local label = gameClock.add{type="label", name="clockLabel"}
		
	player.gui.top["gameClock"].visible = false
	
	local mapRegenerating = player.gui.center.add{type="frame", name="mapRegenerating", caption = {"mapRegenerating.frame-heading"}}
	mapRegenerating.style.padding = {0, 6, 0, 6}
	player.gui.center["mapRegenerating"].visible = true
	
end

function onGuiClick(event)
	if event.element and event.element.valid then
		local element = event.element
        if element.name == "biter-clash-regenerate-map" then
            reGenerateMap()
            return
        end
        if not global["mapToBeCloned2"] then
	        if element.name == "biter-clash-join-north" then
	            joinNorth(game.players[event.element.player_index])
	            return
	        end
	        if element.name == "biter-clash-join-south" then
	            joinSouth(game.players[event.element.player_index])
	            return
	        end
	        if element.name == "biter-clash-spectate" then
	            spectate(game.players[event.element.player_index])
	            return
	        end
	        if element.name == "biter-clash-start-game" then
	            startGame()
	            return
	        end
	        if element.name == "biter-clash-exit-team" then
	        	player = game.players[event.element.player_index]
	        	player.gui.top["ready"].visible = false
	        	player.gui.top["ready"]["buttonflow2"]["biter-clash-ready"].state = false
	            spectate(player)
	            return
	        end
	    end
	end
end

function onGuiCheckedStateChanged(event)
	if event.element and event.element.valid then
		local element = event.element
		if element.name == "biter-clash-ready" then
			local setReady = false
			if element.state == true then
				setReady = true
			end
			teamReady(game.players[event.element.player_index], setReady)
        	return
        end
	end
end