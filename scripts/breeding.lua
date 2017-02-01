function breed(dad, mom)
	local child = {}
	child.position = {x = mom.position.x, y = mom.position.y}
	child.genome = {}
	for k,v in pairs(mom.genome) do
		if math.random() > 0.5 then
			child.genome[k] = {}
			child.genome[k].m = v.m
		else
			child.genome[k] = {}
			child.genome[k].m = v.d
		end
	end
	for k,v in pairs(dad.genome) do
		if math.random() > 0.5 then
			child.genome[k].d = v.m
		else
			child.genome[k].d = v.d
		end
	end
	return child
end