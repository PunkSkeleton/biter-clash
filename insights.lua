function addProductionItem(northWindow, southWindow, name)
	northProductionFlowName = "northProduction" .. name .. "Flow"
	southProductionFlowName = "southProduction" .. name .. "Flow"
	northProductionIconName = "northProduction" .. name .. "Icon"
	southProductionIconName = "southProduction" .. name .. "Icon"
	northProductionValueName = "northProduction" .. name .. "Value"
	southProductionValueName = "southProduction" .. name .. "Value"
	iconString = "[img=item." .. name .. "]:"
	northProductionStatistics = game.forces["north"].get_item_production_statistics(storage["surfaceName"])
	southProductionStatistics = game.forces["south"].get_item_production_statistics(storage["surfaceName"])
    northItemFlow = northWindow.add{type = "flow", name = northProductionFlowName, direction = "horizontal"}
	northItemFlow.add{type = "label", name = northProductionIconName, style = "biter-clash_production_icon", caption = iconString }
	northItemFlow.add{type = "label", name = northProductionValueName, style = "biter-clash_production_value", caption = northProductionStatistics.get_input_count(name) }
	southItemFlow = southWindow.add{type = "flow", name = southProductionFlowName, direction = "horizontal"}
	southItemFlow.add{type = "label", name = southProductionIconName, style = "biter-clash_production_icon", caption = iconString }
	southItemFlow.add{type = "label", name = southProductionValueName, style = "biter-clash_production_value", caption =  southProductionStatistics.get_input_count(name) }
end

function prepareProductionWindow(parentWindow)
	production = parentWindow.add{type = "flow", name = "production", direction = "vertical"}
	productionPeriodSelector = production.add{type = "flow", name = "productionPeriodSelector", direction = "horizontal"}
	productionTotal = productionPeriodSelector.add{type = "button", name = "productionTotal", style = "biter-clash_period", caption = "Total" }
	productionOneMinute = productionPeriodSelector.add{type = "button", name = "productionOneMinute", style = "biter-clash_period", caption = "1m" }
	productionTenMinutes = productionPeriodSelector.add{type = "button", name = "productionTenMinutes", style = "biter-clash_period", caption = "10m" }
	productionOneHour = productionPeriodSelector.add{type = "button", name = "productionOneHour", style = "biter-clash_period", caption = "1h" }
	productionMainWindow = production.add{type = "flow", name = "productionMainWindow", direction = "horizontal"}
	productionLeftWindow = productionMainWindow.add{type = "flow", name = "productionLeftWindow", direction = "vertical"}
	productionLeftWindow.add{type = "label", name = "productionLeftLabel", caption = "North production: ", style = "biter-clash_help"}
	productionRightWindow = productionMainWindow.add{type = "flow", name = "productionRightWindow", direction = "vertical"}
	productionRightWindow.add{type = "label", name = "productionLeftLabel", caption = "South production: ", style = "biter-clash_help"}
	for i, item in pairs(storage["insightsItems"]) do
		addProductionItem(productionLeftWindow, productionRightWindow, item)
	end
	productionLeftWindow.style.width = 500
	productionRightWindow.style.width = 500
	production.visible = false
	return production
end

function updateProductionWindowItem(parentWindow, name, period)
	northFlowName = "northProduction" .. name .. "Flow"
	southFlowName = "southProduction" .. name .. "Flow"
	northValueName = "northProduction" .. name .. "Value"
	southValueName = "southProduction" .. name .. "Value"
	northValueWindow = parentWindow["production"]["productionMainWindow"]["productionLeftWindow"][northFlowName][northValueName]
	southValueWindow = parentWindow["production"]["productionMainWindow"]["productionRightWindow"][southFlowName][southValueName]
	northValueWindow.caption = game.forces["north"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="input", precision_index=period, count=true})
	southValueWindow.caption = game.forces["south"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="input", precision_index=period, count=true})
end

function updateProductionWindow(parentWindow, period)
	for i, item in pairs(storage["insightsItems"]) do
		updateProductionWindowItem(parentWindow, item, period)
	end
end

function addConsumptionItem(northWindow, southWindow, name)
	northConsumptionFlowName = "northConsumption" .. name .. "Flow"
	southConsumptionFlowName = "southConsumption" .. name .. "Flow"
	northConsumptionIconName = "northConsumption" .. name .. "Icon"
	southConsumptionIconName = "southConsumption" .. name .. "Icon"
	northConsumptionValueName = "northConsumption" .. name .. "Value"
	southConsumptionValueName = "southConsumption" .. name .. "Value"
	iconString = "[img=item." .. name .. "]:"
	northConsumptionStatistics = game.forces["north"].get_item_production_statistics(storage["surfaceName"])
	southConsumptionStatistics = game.forces["south"].get_item_production_statistics(storage["surfaceName"])
	northTotal = northConsumptionStatistics.get_output_count(name)
	southTotal = southConsumptionStatistics.get_output_count(name)
    northItemFlow = northWindow.add{type = "flow", name = northConsumptionFlowName, direction = "horizontal"}
	northItemFlow.add{type = "label", name = northConsumptionIconName, style = "biter-clash_production_icon", caption = iconString }
	northItemFlow.add{type = "label", name = northConsumptionValueName, style = "biter-clash_production_value", caption = northTotal }
	southItemFlow = southWindow.add{type = "flow", name = southConsumptionFlowName, direction = "horizontal"}
	southItemFlow.add{type = "label", name = southConsumptionIconName, style = "biter-clash_production_icon", caption = iconString }
	southItemFlow.add{type = "label", name = southConsumptionValueName, style = "biter-clash_production_value", caption =  southTotal }
end

function prepareConsumptionWindow(parentWindow)
	consumption = parentWindow.add{type = "flow", name = "consumption", direction = "vertical"}
	consumptionPeriodSelector = consumption.add{type = "flow", name = "consumptionPeriodSelector", direction = "horizontal"}
	consumptionTotal = consumptionPeriodSelector.add{type = "button", name = "consumptionTotal", style = "biter-clash_period", caption = "Total" }
	consumptionOneMinute = consumptionPeriodSelector.add{type = "button", name = "consumptionOneMinute", style = "biter-clash_period", caption = "1m" }
	consumptionTenMinutes = consumptionPeriodSelector.add{type = "button", name = "consumptionTenMinutes", style = "biter-clash_period", caption = "10m" }
	consumptionOneHour = consumptionPeriodSelector.add{type = "button", name = "consumptionOneHour", style = "biter-clash_period", caption = "1h" }
	consumptionMainWindow = consumption.add{type = "flow", name = "consumptionMainWindow", direction = "horizontal"}
	consumptionLeftWindow = consumptionMainWindow.add{type = "flow", name = "consumptionLeftWindow", direction = "vertical"}
	consumptionLeftWindow.add{type = "label", name = "consumptionLeftLabel", caption = "North consumption: ", style = "biter-clash_help"}
	consumptionRightWindow = consumptionMainWindow.add{type = "flow", name = "consumptionRightWindow", direction = "vertical"}
	consumptionRightWindow.add{type = "label", name = "consumptionLeftLabel", caption = "South consumption: ", style = "biter-clash_help"}
	for i, item in pairs(storage["insightsItems"]) do
		addConsumptionItem(consumptionLeftWindow, consumptionRightWindow, item)
	end
	consumptionLeftWindow.style.width = 500
	consumptionRightWindow.style.width = 500
	consumption.visible = false
	return consumption
end

function updateConsumptionWindowItemWithKills(parentWindow, name, period)
	northFlowName = "northConsumption" .. name .. "Flow"
	southFlowName = "southConsumption" .. name .. "Flow"
	northValueName = "northConsumption" .. name .. "Value"
	southValueName = "southConsumption" .. name .. "Value"
	northValueWindow = parentWindow["consumption"]["consumptionMainWindow"]["consumptionLeftWindow"][northFlowName][northValueName]
	southValueWindow = parentWindow["consumption"]["consumptionMainWindow"]["consumptionRightWindow"][southFlowName][southValueName]
	northNumericValue = game.forces["north"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="output", precision_index=period, count=true}) + game.forces["north"].get_kill_count_statistics(storage["surfaceName"]).get_flow_count({name=name, category="output", precision_index=period, count=true})
	southNumericValue = game.forces["south"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="output", precision_index=period, count=true}) + game.forces["south"].get_kill_count_statistics(storage["surfaceName"]).get_flow_count({name=name, category="output", precision_index=period, count=true})
	northValueWindow.caption = northNumericValue
	southValueWindow.caption = southNumericValue
end

function updateConsumptionWindowItem(parentWindow, name, period)
	northFlowName = "northConsumption" .. name .. "Flow"
	southFlowName = "southConsumption" .. name .. "Flow"
	northValueName = "northConsumption" .. name .. "Value"
	southValueName = "southConsumption" .. name .. "Value"
	northValueWindow = parentWindow["consumption"]["consumptionMainWindow"]["consumptionLeftWindow"][northFlowName][northValueName]
	southValueWindow = parentWindow["consumption"]["consumptionMainWindow"]["consumptionRightWindow"][southFlowName][southValueName]
	northNumericValue = game.forces["north"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="output", precision_index=period, count=true})
	southNumericValue = game.forces["south"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="output", precision_index=period, count=true})
	northValueWindow.caption = northNumericValue
	southValueWindow.caption = southNumericValue
end

function updateConsumptionWindow(parentWindow, period)
	for i, item in pairs(storage["insightsNonKillableItems"]) do
		updateConsumptionWindowItem(parentWindow, item, period)
	end
	for i, item in pairs(storage["insightsKillableItems"]) do
		updateConsumptionWindowItemWithKills(parentWindow, item, period)
	end
end

function addItemFlowItem(northWindow, southWindow, name)
	northItemFlowFlowName = "northItemFlow" .. name .. "Flow"
	southItemFlowFlowName = "southItemFlow" .. name .. "Flow"
	northItemFlowIconName = "northItemFlow" .. name .. "Icon"
	southItemFlowIconName = "southItemFlow" .. name .. "Icon"
	northItemFlowValueName = "northItemFlow" .. name .. "Value"
	southItemFlowValueName = "southItemFlow" .. name .. "Value"
	iconString = "[img=item." .. name .. "]:"
	northItemFlowStatistics = game.forces["north"].get_item_production_statistics(storage["surfaceName"])
	southItemFlowStatistics = game.forces["south"].get_item_production_statistics(storage["surfaceName"])
	northTotal = northItemFlowStatistics.get_output_count(name)
	southTotal = southItemFlowStatistics.get_output_count(name)
    northItemFlow = northWindow.add{type = "flow", name = northItemFlowFlowName, direction = "horizontal"}
	northItemFlow.add{type = "label", name = northItemFlowIconName, style = "biter-clash_production_icon", caption = iconString }
	northItemFlow.add{type = "label", name = northItemFlowValueName, style = "biter-clash_production_value", caption = northTotal }
	southItemFlow = southWindow.add{type = "flow", name = southItemFlowFlowName, direction = "horizontal"}
	southItemFlow.add{type = "label", name = southItemFlowIconName, style = "biter-clash_production_icon", caption = iconString }
	southItemFlow.add{type = "label", name = southItemFlowValueName, style = "biter-clash_production_value", caption =  southTotal }
end

function prepareItemFlowWindow(parentWindow)
	itemFlow = parentWindow.add{type = "flow", name = "itemFlow", direction = "vertical"}
	itemFlowPeriodSelector = itemFlow.add{type = "flow", name = "itemFlowPeriodSelector", direction = "horizontal"}
	itemFlowTotal = itemFlowPeriodSelector.add{type = "button", name = "itemFlowTotal", style = "biter-clash_period", caption = "Total" }
	itemFlowOneMinute = itemFlowPeriodSelector.add{type = "button", name = "itemFlowOneMinute", style = "biter-clash_period", caption = "1m" }
	itemFlowTenMinutes = itemFlowPeriodSelector.add{type = "button", name = "itemFlowTenMinutes", style = "biter-clash_period", caption = "10m" }
	itemFlowOneHour = itemFlowPeriodSelector.add{type = "button", name = "itemFlowOneHour", style = "biter-clash_period", caption = "1h" }
	itemFlowMainWindow = itemFlow.add{type = "flow", name = "itemFlowMainWindow", direction = "horizontal"}
	itemFlowLeftWindow = itemFlowMainWindow.add{type = "flow", name = "itemFlowLeftWindow", direction = "vertical"}
	itemFlowLeftWindow.add{type = "label", name = "itemFlowLeftLabel", caption = "North item flow: ", style = "biter-clash_help"}
	itemFlowRightWindow = itemFlowMainWindow.add{type = "flow", name = "itemFlowRightWindow", direction = "vertical"}
	itemFlowRightWindow.add{type = "label", name = "itemFlowLeftLabel", caption = "South item flow: ", style = "biter-clash_help"}
	for i, item in pairs(storage["insightsItems"]) do
		addItemFlowItem(itemFlowLeftWindow, itemFlowRightWindow, item)
	end
	itemFlowLeftWindow.style.width = 500
	itemFlowRightWindow.style.width = 500
	itemFlow.visible = false
	return itemFlow
end

function updateItemFlowWindowItemWithKills(parentWindow, name, period)
	northFlowName = "northItemFlow" .. name .. "Flow"
	southFlowName = "southItemFlow" .. name .. "Flow"
	northValueName = "northItemFlow" .. name .. "Value"
	southValueName = "southItemFlow" .. name .. "Value"
	northValueWindow = parentWindow["itemFlow"]["itemFlowMainWindow"]["itemFlowLeftWindow"][northFlowName][northValueName]
	southValueWindow = parentWindow["itemFlow"]["itemFlowMainWindow"]["itemFlowRightWindow"][southFlowName][southValueName]
	northConsumptionNumericValue = game.forces["north"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="output", precision_index=period, count=true}) + game.forces["north"].get_kill_count_statistics(storage["surfaceName"]).get_flow_count({name=name, category="output", precision_index=period, count=true})
	southConsumptionNumericValue = game.forces["south"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="output", precision_index=period, count=true}) + game.forces["south"].get_kill_count_statistics(storage["surfaceName"]).get_flow_count({name=name, category="output", precision_index=period, count=true})
	northValueWindow.caption = game.forces["north"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="input", precision_index=period, count=true}) - northConsumptionNumericValue
	southValueWindow.caption = game.forces["south"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="input", precision_index=period, count=true}) - southConsumptionNumericValue
end

function updateItemFlowWindowItem(parentWindow, name, period)
	northFlowName = "northItemFlow" .. name .. "Flow"
	southFlowName = "southItemFlow" .. name .. "Flow"
	northValueName = "northItemFlow" .. name .. "Value"
	southValueName = "southItemFlow" .. name .. "Value"
	northValueWindow = parentWindow["itemFlow"]["itemFlowMainWindow"]["itemFlowLeftWindow"][northFlowName][northValueName]
	southValueWindow = parentWindow["itemFlow"]["itemFlowMainWindow"]["itemFlowRightWindow"][southFlowName][southValueName]
	northConsumptionNumericValue = game.forces["north"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="output", precision_index=period, count=true})
	southConsumptionNumericValue = game.forces["south"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="output", precision_index=period, count=true})
	northValueWindow.caption = game.forces["north"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="input", precision_index=period, count=true}) - northConsumptionNumericValue
	southValueWindow.caption = game.forces["south"].get_item_production_statistics(storage["surfaceName"]).get_flow_count({name=name, category="input", precision_index=period, count=true}) - southConsumptionNumericValue
end

function updateItemFlowWindow(parentWindow, period)
	for i, item in pairs(storage["insightsNonKillableItems"]) do
		updateItemFlowWindowItem(parentWindow, item, period)
	end
	for i, item in pairs(storage["insightsKillableItems"]) do
		updateItemFlowWindowItemWithKills(parentWindow, item, period)
	end
end