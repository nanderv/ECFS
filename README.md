# Entity Component Filter System
Entity Component Filter System for Love2d. First step: writing down what the hell it even means.

## What is an Entity Component Filter System?
And entity component filter system is a way to organize the way data influences logic within a game. 
It is built around the idea of splitting up responsibilities between plain data objects, filters and systems.

### Entity
Entities are the objects within the game. In the most basic idea they are an entry in the entity-table, with a table containing their properties. The properties of entities are called components.

### Component
Components are properties of entities. 

### Filter
Filters are pretty much a reverse inheritence system. 'It has four wheels, so it is a car' is a sort-of-correct example of how a filter works. 

### System
A system is a piece of logic. It contains logic functions that run each frame (update, draw), logic functions that run upon load (load), and logic functions that run when an entity registers to a certain filter:
```
local s = {}
s.functions = {}
s.functions.update = function() end
s.register = {}
s.unregister = {}
s.register.wall   = function(entity) end
s.unregister.wall = function(entity) end
```
