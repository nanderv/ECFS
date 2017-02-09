core.entity = {}

local unregisters = core.system.unregisters

core.entity.add = core.filter.update

function core.entity.remove(entity)
	local R = core.filter.rules

	for _ , name_rules in pairs(R) do
		local name = name_rules[1]
		local ind = F[name][entity]
		if ind then
			E[name][ind] = E[name][#E[name]]
			E[name][#E[name]] = nil
			F[name][entity] = nil
			if unregisters[name] then
				for _,v in  pairs(unregisters[name]) do
					v.unregisters[name](entity)
				end
			end
		end	
	end
end
