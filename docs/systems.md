A system is created by creating a new script file.
This script file should create a local table, which it returns at the end.

local s = {}

-- Functions contains all functionality this system has. Often the program logic will loop through all systems with a certain function (by name) and execute those
-- Important ones are update (dt) and draw()
s.functions = {}
s.functions.update = function(dt)
end

-- Registers contain functions that get triggered when an entity gets assigned to a certain filter.
s.registers = {}
s.registers.test = function(entity) print(entity) end

-- unregisters contain functions that get triggered when an entity loses it's status as being attached to a certain filter.
s.unregisters = {}



return s
