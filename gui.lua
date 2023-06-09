require "mapGen"
require "guiActions"

function addTitlebar(gui, caption, close_button_name)
  local titlebar = gui.add{type = "flow"}
  titlebar.add{
    type = "label",
    style = "frame_title",
    caption = caption,
    ignored_by_interaction = true,
  }
  local filler = titlebar.add{
    type = "empty-widget",
    style = "draggable_space",
    ignored_by_interaction = true,
  }
  filler.style.height = 24
  filler.style.horizontally_stretchable = true
  titlebar.add{
    type = "sprite-button",
    name = close_button_name,
    style = "frame_action_button",
    sprite = "utility/close_white",
    hovered_sprite = "utility/close_black",
    clicked_sprite = "utility/close_black",
    tooltip = {"gui.close-instruction"},
  }
end

function createGui(player)
	if player.gui.top["biter-clash"] then
		return 
	end
	local frame = player.gui.top.add{
		type = "frame", name = "biter-clash", caption = {"biter-clash.frame-heading"}, direction = "vertical", style = "biter-clash_frame"}
	frame.style.width = 250
	
	local buttoncontainer = frame.add{ type = "flow", name = "buttonflow", direction = "vertical"}
	
	buttoncontainer.add{ type = "button", name = "biter-clash-regenerate-map", style = "rounded_button", caption = {"biter-clash.regenerate-map"} }
	buttoncontainer.style.minimal_width = 100
	buttoncontainer.style.horizontally_stretchable = true
	
	buttoncontainer.add{ type = "button", name = "biter-clash-join-north", style = "rounded_button", caption = {"biter-clash.join-north"} }
	buttoncontainer.style.minimal_width = 100
	buttoncontainer.style.horizontally_stretchable = true
	
	buttoncontainer.add{ type = "button", name = "biter-clash-join-south", style = "rounded_button", caption = {"biter-clash.join-south"} }
	buttoncontainer.style.minimal_width = 100
	buttoncontainer.style.horizontally_stretchable = true
	
	buttoncontainer.add{ type = "button", name = "biter-clash-spectate", style = "rounded_button", caption = {"biter-clash.spectate"} }
	buttoncontainer.style.minimal_width = 100
	buttoncontainer.style.horizontally_stretchable = true
	
	buttoncontainer.add{ type = "button", name = "biter-clash-start-game", style = "rounded_button", caption = {"biter-clash.start-game"} }
	buttoncontainer.style.minimal_width = 100
	buttoncontainer.style.horizontally_stretchable = true
	
	local frame2 = player.gui.top.add{
		type = "frame", name = "ready", caption = {"ready.frame-heading"}, direction = "vertical", style = "biter-clash_frame"}
	frame.style.width = 150
	
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
	
	mapRegenerating = player.gui.center.add{type = "frame", name = "mapRegenerating", direction = "vertical"}
	addTitlebar(mapRegenerating, "Map is generated", "closeRegenerateMap")
	mapRegeneratingTextWindow = mapRegenerating.add{type = "label", caption = {"mapRegenerating.frame-heading"}}
	mapRegeneratingTextWindow.style = "biter-clash_help"
	mapRegeneratingTextWindow.style.width = 500
	player.gui.center["mapRegenerating"].visible = false
	
	guide = player.gui.center.add{type = "frame", name = "guide", direction = "vertical"}
	addTitlebar(guide, "Guide", "closeGuide")
	guideInnerWindow = guide.add{type = "frame", name = "guideInnerWindow", direction = "horizontal"}
	guideIndex = guideInnerWindow.add{type = "frame", name = "guideIndex", direction = "vertical"}
	guideIndex.style.font = "default-large"
	guideText = guideInnerWindow.add{type = "frame", name = "guideText", direction = "vertical"}
	guideIndex.add{type = "label", name = "guideBasics", caption = "Basics", style = "biter-clash_help"}
	guideIndex.add{type = "label", name = "guideAttacking", caption = "Attacking", style = "biter-clash_help"}
	guideIndex.add{type = "label", name = "guideRocket", caption = "Rocket", style = "biter-clash_help"}
	guideIndex.add{type = "label", name = "guideStart", caption = "Game Start", style = "biter-clash_help"}
	guideIndex.add{type = "label", name = "guideStarterPack", caption = "Starter Pack", style = "biter-clash_help"}
	guideIndex.add{type = "label", name = "guideEnemies", caption = "Enemies", style = "biter-clash_help"}
	guideIndex.add{type = "label", name = "guideBalance", caption = "Balance Changes", style = "biter-clash_help"}
	guideIndex.add{type = "label", name = "guideInsights", caption = "Insights", style = "biter-clash_help"}
	guideTextWindow = guideText.add{type = "label", name = "guideTextCore", caption = {"guide.basics"}}
	guideTextWindow.style = "biter-clash_help"
	guideTextWindow.style.width = 1000
	guideTextWindow.style.height = 800
	player.gui.center["guide"].visible = false
	
	insights = player.gui.center.add{type = "frame", name = "insights", direction = "vertical"}
	addTitlebar(insights, "Insigths", "closeInsigths")
	insightsInnerWindow = insights.add{type = "frame", name = "insightsInnerWindow", direction = "horizontal"}
	insightsIndex = insightsInnerWindow.add{type = "frame", name = "insigthsIndex", direction = "vertical"}
	insightsIndex.style.font = "default-large"
	northText = insightsInnerWindow.add{type = "scroll-pane", name = "northText", direction = "vertical"}
	northText.style.height = 800
	southText = insightsInnerWindow.add{type = "scroll-pane", name = "southText", direction = "vertical"}
	southText.style.height = 800
	insightsIndex.add{type = "label", name = "insightsResearch", caption = "Research", style = "biter-clash_help"}
	northTextWindow = northText.add{type = "label", name = "northTextCore", caption = global["northResearchedString"], style = "biter-clash_help"}
	southTextWindow = southText.add{type = "label", name = "southTextCore", caption = global["southResearchedString"], style = "biter-clash_help"}
	northTextWindow.style.width = 500
	southTextWindow.style.width = 500
	player.gui.center["insights"].visible = false
	
	local guideToggle = player.gui.left.add{
		type = "frame", name = "guideToggle", caption = "", direction = "vertical", style = "biter-clash_frame"}
	guideToggle.style.width = 150
	local buttoncontainer = guideToggle.add{ type = "flow", name = "guideToggleFlow", direction = "vertical"}
	buttoncontainer.add{ type = "button", name = "biter-clash-show-guide", style = "rounded_button", caption = "Guide" }
	buttoncontainer.style.minimal_width = 50
	buttoncontainer.style.horizontally_stretchable = true
	buttoncontainer.add{ type = "button", name = "biter-clash-show-insigths", style = "rounded_button", caption = "Insights" }
	buttoncontainer.style.minimal_width = 50
	buttoncontainer.style.horizontally_stretchable = true
	player.gui.left["guideToggle"].visible = true
	
end

function onGuiClick(event)
	if event.element and event.element.valid then
		local element = event.element
		if event.element.name == "biter-clash-show-guide" then
			player = game.players[event.element.player_index]
		    player.gui.center["guide"].visible = true
		end
		if event.element.name == "biter-clash-show-insigths" then
			player = game.players[event.element.player_index]
			player.gui.center["insights"]["insightsInnerWindow"]["northText"]["northTextCore"].caption = global["northResearchedString"]
		    player.gui.center["insights"]["insightsInnerWindow"]["southText"]["southTextCore"].caption = global["southResearchedString"]
		    player.gui.center["insights"].visible = true
		end
		if event.element.name == "closeRegenerateMap" then
			player = game.players[event.element.player_index]
		    player.gui.center["mapRegenerating"].visible = false
		end
		if event.element.name == "closeGuide" then
			player = game.players[event.element.player_index]
		    player.gui.center["guide"].visible = false
		end
		if event.element.name == "closeInsigths" then
			player = game.players[event.element.player_index]
		    player.gui.center["insights"].visible = false
		end
		if event.element.name == "guideBasics" then
			player = game.players[event.element.player_index]
		    player.gui.center["guide"]["guideInnerWindow"]["guideText"]["guideTextCore"].caption = {"guide.basics"}
		end
		if event.element.name == "guideAttacking" then
			player = game.players[event.element.player_index]
		    player.gui.center["guide"]["guideInnerWindow"]["guideText"]["guideTextCore"].caption = {"guide.attacking"}
		end
		if event.element.name == "guideRocket" then
			player = game.players[event.element.player_index]
		    player.gui.center["guide"]["guideInnerWindow"]["guideText"]["guideTextCore"].caption = {"guide.rocket"}
		end
		if event.element.name == "guideStart" then
			player = game.players[event.element.player_index]
		    player.gui.center["guide"]["guideInnerWindow"]["guideText"]["guideTextCore"].caption = {"guide.gameStart"}
		end
		if event.element.name == "guideStarterPack" then
			player = game.players[event.element.player_index]
		    player.gui.center["guide"]["guideInnerWindow"]["guideText"]["guideTextCore"].caption = {"guide.starterPack"}
		end
		if event.element.name == "guideBalance" then
			player = game.players[event.element.player_index]
		    player.gui.center["guide"]["guideInnerWindow"]["guideText"]["guideTextCore"].caption = {"guide.balance"}
		end
		if event.element.name == "guideEnemies" then
			player = game.players[event.element.player_index]
		    player.gui.center["guide"]["guideInnerWindow"]["guideText"]["guideTextCore"].caption = {"guide.enemies"}
		end
		if event.element.name == "guideInsights" then
			player = game.players[event.element.player_index]
		    player.gui.center["guide"]["guideInnerWindow"]["guideText"]["guideTextCore"].caption = {"guide.insights"}
		end
		if event.element.name == "insightsResearch" then
			player = game.players[event.element.player_index]
		    player.gui.center["insights"]["insightsInnerWindow"]["northText"]["northTextCore"].caption = global["northResearchedString"]
		    player.gui.center["insights"]["insightsInnerWindow"]["southText"]["southTextCore"].caption = global["southResearchedString"]
		end
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