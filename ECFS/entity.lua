core.entity = {}

function core.entity.add(entity)
	core.filter.update(entity)
end

function core.entity.remove(entity)
	for _ , name_rules in pairs(core.filter.rules) do
		local name = name_rules[1]
		local ind = F[name][entity]
		if ind then
			E[name][ind] = E[name][#E[name]]
			E[name][#E[name]] = nil
			F[name][entity] = nil
			if core.system.unregisters[name] then
				for _,v in  pairs(core.system.unregisters[name]) do
					v.unregisters[name](entity)
				end
			end
		end	
	end
end
