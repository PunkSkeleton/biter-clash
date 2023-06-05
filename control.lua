require "utils"
require "pregame"
require "mapGen"
require "gui"
require "resources"
require "ai.ai"
require "globals"
require "onTicks"
require "eventHandlers"

script.on_init(onGameStart)
script.on_event(defines.events.on_tick, onTick)
script.on_event(defines.events.on_game_created_from_scenario, onInit)
script.on_event(defines.events.on_player_joined_game, onPlayerJoinedGame)
script.on_event(defines.events.on_gui_click, onGuiClick)
script.on_event(defines.events.on_built_entity, onBuiltEntity)
script.on_nth_tick(180, every180thTick)
script.on_nth_tick(60, every60thTick)
script.on_nth_tick(17, every17thTick)
script.on_event(defines.events.on_research_finished, onResearchFinished)
script.on_event(defines.events.on_research_started, onResearchStarted)
script.on_event(defines.events.on_entity_destroyed, onEntityDestroyed)
script.on_event(defines.events.on_rocket_launched, onRocketLaunched)
script.on_event(defines.events.on_player_respawned, onPlayerRespawned)
script.on_nth_tick(300, on300thtick)
script.on_event(defines.events.on_gui_checked_state_changed, onGuiCheckedStateChanged)
script.on_event(defines.events.on_player_died, onPlayerDied)
