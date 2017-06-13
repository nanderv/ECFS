-- A system that prints out whenever an entity gets added or removed from the game.
local s = {}
s.functions = {}
s.functions.update = function(dt)
end
s.registers = {}
s.registers.A = function(entity)
end
s.unregisters = {}
s.unregisters.A = function(entity)
    print("REM", entity)
end
return s
