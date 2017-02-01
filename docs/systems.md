#Systems
A system is created by creating a new script file.

This script file should create a local table, which it returns at the end.

## Functions
Function is a table of String -> Function. It contains functions such as update(dt), or draw(), which will be added to the respective Function-list.

## Register and Unregister-functions
The register and unregister functions are used to specify functions that will be executed when entities are added or removed from the lists of certain filters. The link between Systems and Filters is not explicit, so this is why any system could conceivably register and unregister based on any filter.

## Example:
```
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
```