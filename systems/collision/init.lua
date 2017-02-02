-- Collision system
local s = {}
local bump = require 'lib.bump'
local world = bump.newWorld(50)
local lib = require 'systems.collision.lib'
s.functions = {}
s.circles = {}
s.boxes = {}
CIRC = s.circles
BOXES = s.boxes
local rpo = {}
s.prev = {}

local function checkCollision (entity1)
	local shape1 = nil
	local x1, y1 = entity1.position.x, entity1.position.y
	shape1 = s.circles[entity1]
	-- Use bump to check if entities are near enough. It uses either a circle around it or a box around it. The circle is rotation-safe, the box isn't.
	local _, _, cols, len = world:move(entity1, entity1.position.x-shape1,entity1.position.y-shape1)
	for _,b in ipairs(cols) do
		local entity2 = b.other
		if entity1 ~= entity2  then

				-- Check if the collision is necessary. I think this is slightly slower than the previous check, so that's why this one is later. Not tested for speed.
				if lib.check_rule(entity1, entity2) then
					print("A")
					local p1 = rpo[entity1] or lib.rotate_poly(entity1)
					local p2 = rpo[entity2] or lib.rotate_poly(entity2)
					rpo[entity1] = p1
					rpo[entity2] = p2

					-- polygon collision
					collided = lib.polygon_in_polygon(p1, p2, entity1.position, entity2.position)

					-- Actual logic
					if collided then
						print("HIT")
						lib.execute_if_rule(entity1, entity2, s.prev[entity1])
					end
				end
		end
	end
	s.prev[entity1] = {x = entity1.position.x, y = entity1.position.y,  rotation = entity1.position.rotation}
end


local function reverser(entity1, entity2, pos)
	if entity1.mover then
	entity1.mover.x = -entity1.mover.x
	entity1.mover.y = -entity1.mover.y
end
end


s.functions.update = function(dt)
	rpo = {}
	for k,v in ipairs(E.dynamic_collision) do
		checkCollision(v)
	end
	for k,v in ipairs(E.dynamic_collision) do
		if v.collision.moved then
			checkCollision(v)
			v.collision.moved = nil
		end
	end

end
s.functions.reset = function()
	world = bump.newWorld(50)

end

s.registers = {}
s.registers.collision = function(entity)
	if not entity.collision.box then
		local x,y,rad = lib.circle_around(entity, s.circles)
		world:add(entity,x-rad, y-rad,rad*2, rad*2)
	else
		local x,y, minx,miny,maxx, maxy = lib.aabb_around(entity, s.boxes)
		world:add(entity,x+minx, y+miny,x+maxx, y+maxy)


	end
	s.prev[entity] = {x = entity.position.x, y = entity.position.y,  rotation = entity.position.rotation}
end
core.update_entity_collision_shape = function (entity)
	local x,y,rad = lib.circle_around(entity, s.circles)
	world:add(entity,x-rad, y-rad,rad*2, rad*2)
end

s.unregisters = {}
s.unregisters.collision = function(entity)
	print("Static  collision entity removed")
	s.circles[entity] = nil
	world:remove(entity)
	s.prev[entity] = nil

end


lib.add_rule("test", "test", core.DoAll(lib.trivial_solve, reverser))
return s
