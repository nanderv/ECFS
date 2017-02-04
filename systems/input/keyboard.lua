--core.When("!", "A", core.keyboard.isDown("y") , printCount())
local Down  =  core.keyboard.isDown
local When  = core.When 
local While = core.While
-- A system that applies a constant movement to an object.
local s = {}
s.functions = {}

local function doMoveUp(entity)
	return function (dt)
		entity.position.y = entity.position.y - dt * 100
	end
end
local function doMoveDown(entity)
	return function (dt)
		entity.position.y = entity.position.y + dt * 100
	end
end

local function doMoveLeft(entity)
	return function (dt)
		entity.position.x = entity.position.x - dt * 100
	end
end

local function doMoveRight(entity)
	return function (dt)
		entity.position.x = entity.position.x + dt * 100
	end
end

s.registers = {}
s.registers.key_controls = function(entity)
	print("ADDING CONTROLS")
	While(entity, "key_controls",Down("w"),doMoveUp(entity))
	While(entity, "key_controls",Down("s"),doMoveDown(entity))
	While(entity, "key_controls",Down("a"),doMoveLeft(entity))
	While(entity, "key_controls",Down("d"),doMoveRight(entity))
end

s.unregisters = {}
s.unregisters.key_controls = function(entity)
	core.Rem_Events(entity,"key_controls")
end

return s
