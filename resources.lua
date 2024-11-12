function fillFreeResourceChests(fraction)
	if storage["northIronChest1"].valid then
		storage["northIronChest1"].insert({name="iron-plate", count=math.ceil(15*fraction)})
	end
	if storage["northIronChest2"].valid then
		storage["northIronChest2"].insert({name="iron-plate", count=math.ceil(15*fraction)})
	end
	if storage["southIronChest1"].valid then
		storage["southIronChest1"].insert({name="iron-plate", count=math.ceil(15*fraction)})
	end
	if storage["southIronChest2"].valid then
		storage["southIronChest2"].insert({name="iron-plate", count=math.ceil(15*fraction)})
	end
	if storage["northCopperChest"].valid then
		storage["northCopperChest"].insert({name="copper-plate", count=math.ceil(15*fraction)})
	end
	if storage["southCopperChest"].valid then
		storage["southCopperChest"].insert({name="copper-plate", count=math.ceil(15*fraction)})
	end
	if storage["northStoneChest"].valid then
		storage["northStoneChest"].insert({name="stone", count=math.ceil(7.5*fraction)})
	end
	if storage["southStoneChest"].valid then
		storage["southStoneChest"].insert({name="stone", count=math.ceil(7.5*fraction)})
	end
	if storage["northCoalChest"].valid then
		storage["northCoalChest"].insert({name="coal", count=math.ceil(3,75*fraction)})
	end
	if storage["southCoalChest"].valid then
		storage["southCoalChest"].insert({name="coal", count=math.ceil(3.75*fraction)})
	end
	
end