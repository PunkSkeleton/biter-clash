function fillFreeResourceChests(fraction)
	if global["northIronChest1"].valid then
		global["northIronChest1"].insert({name="iron-plate", count=math.ceil(15*fraction)})
	end
	if global["northIronChest2"].valid then
		global["northIronChest2"].insert({name="iron-plate", count=math.ceil(15*fraction)})
	end
	if global["southIronChest1"].valid then
		global["southIronChest1"].insert({name="iron-plate", count=math.ceil(15*fraction)})
	end
	if global["southIronChest2"].valid then
		global["southIronChest2"].insert({name="iron-plate", count=math.ceil(15*fraction)})
	end
	if global["northCopperChest"].valid then
		global["northCopperChest"].insert({name="copper-plate", count=math.ceil(15*fraction)})
	end
	if global["southCopperChest"].valid then
		global["southCopperChest"].insert({name="copper-plate", count=math.ceil(15*fraction)})
	end
	if global["northStoneChest"].valid then
		global["northStoneChest"].insert({name="stone", count=math.ceil(7.5*fraction)})
	end
	if global["southStoneChest"].valid then
		global["southStoneChest"].insert({name="stone", count=math.ceil(7.5*fraction)})
	end
	if global["northCoalChest"].valid then
		global["northCoalChest"].insert({name="coal", count=math.ceil(3,75*fraction)})
	end
	if global["southCoalChest"].valid then
		global["southCoalChest"].insert({name="coal", count=math.ceil(3.75*fraction)})
	end
	
end