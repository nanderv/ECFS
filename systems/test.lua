local s = {}
s.functions = {}
s.functions.update = function(dt)

end
s.registers = {}
s.registers.A = function(entity)
	print("ADD", entity)
end
s.unregisters = {}
s.unregisters.A = function(entity)
	print("REM", entity)
end
return s
