core.filter = {}
core.filter.rules = {}

E = {} -- E is the entity lists, so E.walls is going to contain all walls.
F = {} -- F is the entity list, but as a dictionary

core.filter.add = function(name, rules)
	local R = core.filter.rules
	E[name] = {}
	F[name] = {}
	R[#R+1] = {name, rules}
end

-- Is this function necessary / wanted?
core.filter.remove = function(name)
	local R = core.filter.rules
	local name = name[1]
	E[name] = nil
	F[name] = nil
	for k,v in ipairs(R) do
		if v[1] == name then
			R[k] = R[#R]
			R[#R] = nil
			break
		end
	end

end


core.filter.update = function(entity)
	local R = core.filter.rules
	for _ , name_rules in pairs(R) do
		local name, rule = name_rules[1], name_rules[2]
		local all = true
		for _, r in ipairs(rule) do
			if string.sub(r,1,1) == "-" then

				-- NOT
				if string.sub(r,2,2) == "_" then
					local s = string.sub(r,3)

					if F[s][entity] then 
						all = false
						break
					end
				else
					-- try recursive lookup
					local r = string.sub(r,2)
					local e = entity
					local found = true
					-- Field names can now contain letters, numbers and spaces
					for da in string.gmatch(r, "[%a%s%d]+") do 
						if not e[da] then
							found = false
							break
						end
						e = e[da]
					end
					all = all and not found
					if not all then
						break
					end
				end
			else

				-- NORMAL CASE
				if string.sub(r,1,1) == "_" then
					local s = string.sub(r,2)
					if not F[s][entity] then 
						all = false
						break
					end
				else
					-- try recursive lookup
					local e = entity
					-- Field names can now contain letters, numbers and spaces
					for da in string.gmatch(r, "[%a%s%d]+") do 
						if not e[da] then
							all = false
							break
						end
						e = e[da]
					end
					if not all then
						break
					end
				end
			end
		end

		-- if the state of this entity changes with respect of this filter; update tables
		if not  all and F[name][entity] then
			-- entity was part of filter, but now not anymore
			local ind = F[name][entity]
			E[name][ind] = E[name][#E[name]]
			E[name][#E[name]] = nil
			F[name][entity] = nil
			-- TODO: Run unregister functions
			if core.system.unregisters[name] then
				for _,v in  pairs(core.system.unregisters[name]) do
					v.unregisters[name](entity)
				end
			end
		end

		if all and not F[name][entity] then
			-- entity not was part of filter, but will now be
			E[name][#(E[name])+1] = entity
			F[name][entity] = #(E[name])

			-- TODO: Run register functions
			if core.system.registers[name] then
				for _,v in  pairs(core.system.registers[name]) do
					v.registers[name](entity)
				end
			end
		end
	end
end

-- Add list of all elements. Nice huh, using it's own logic to define this?
core.filter.add("A",{})
