core.system = {}
core.system.functions = {}
core.system.registers = {}
core.system.unregisters = {}
core.system.add = function(system)

	-- Add functionality of system to respected lists
	if system.functions then
		for k,v in pairs(system.functions) do
			if not core.system.functions[k] then
				core.system.functions[k] = {}
			end
			core.system.functions[k][system] = system
		end
	end

	-- Add system to register lists

	if system.registers then
		-- k is the name of a filter
		for k,v in pairs(system.registers) do
			if not core.system.registers[k] then
				core.system.registers[k] = {}
			end
			core.system.registers[k][system] = system
			if E[k] then
				for _,w in pairs(E[k]) do
					system.registers[k](w)
				end
			end
		end
	end

	-- Add system to unregister lists

	if system.unregisters then
		for k,v in pairs(system.unregisters) do
			if not core.system.unregisters[k] then
				core.system.unregisters[k] = {}
			end
			core.system.unregisters[k][system] = system
		end
	end
end

core.system.remove = function(system)
	for k,v in pairs(system.functions) do
		core.system.functions[k][system] = nil
	end
	for k,v in pairs(system.registers) do
		core.system.registers[k][system] = nil
	end
	for k,v in pairs(system.unregisters) do
		if E[k] then
			for _,w in pairs(E[k]) do
				system.unregisters[k](w)
			end
		end
		core.system.unregisters[k][system] = nil
	end
end
