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
		end
	end

end

