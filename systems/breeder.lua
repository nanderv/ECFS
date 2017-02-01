local s = {}
s.functions = {}
s.functions.update = function(dt)

end
s.registers = {}
s.registers.genome = function(entity)
	print("Genome destillation for ", entity)
	distill.run(entity)
	pprint(entity)
end
s.unregisters = {}

return s
