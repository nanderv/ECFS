-- Collision system
local s = {}
local lib = require 'systems.collision.lib'
s.functions = {}
s.circles = {}
s.boxes = {}
CIRC = s.circles
BOXES = s.boxes
local rpo = {}
s.prev = {}

local function checkCollision (entity1)
	for _,entity2 in ipairs(E.collision) do
		local shape1 = nil
		local x1, y1 = entity1.position.x, entity1.position.y

		if entity1.collision.box then
			shape1 = s.boxes[entity1]
		else
			shape1 = s.circles[entity1]
		end
		if entity1 ~= entity2  then

			local shape2 = nil
			if entity2.collision.box then
				shape2 = s.boxes[entity2]
			else
				shape2 = s.circles[entity2]
			end

			local maybe = false
			local x2, y2 = entity2.position.x, entity2.position.y

			if entity2.collision.box then
				local min2x, min2y, max2x, max2y = shape2.minx + x2, shape2.miny + y2, shape2.maxx + x2, shape2.maxy+ y2

				if entity1.collision.box then
					local min1x, min1y, max1x, max1y = shape1.minx + x1, shape1.miny + y1, shape1.maxx + x1, shape1.maxy+ y1
					maybe = max1x >= min2x and max2x >= min2x and max1y >= min2y and max2y >= min1y

				else
					local min1x, min1y, max1x, max1y = -shape1 + x1, -shape1 + y1, shape1 + x1, shape1+ y1
					maybe = max1x >= min2x and max2x >= min2x and max1y >= min2y and max2y >= min1y
					--error("NOT supported yet")	
				end

			elseif entity1.collision.box then
				local min1x, min1y, max1x, max1y = shape1.minx + x1, shape1.miny + y1, shape1.maxx + x1, shape1.maxy+ y1
				local min2x, min2y, max2x, max2y = -shape2 + x2, -shape2 + y2, shape2 + x2, shape2+ y2
				maybe = max1x >= min2x and max2x >= min2x and max1y >= min2y and max2y >= min1y


				--error("NOT supported yet")	
			else
				local dx = entity1.position.x - entity2.position.x
				local dy = entity1.position.y - entity2.position.y
				local distSQ = (dx * dx + dy * dy)
				maybe = distSQ < (shape1 + s.circles[entity2])*(shape1 + s.circles[entity2])
			end

			-- Trivial check: check if squared distances are similar
			
			if maybe  then
				-- Check if the collision is necessary. I think this is slightly slower than the previous check, so that's why this one is later. Not tested for speed.
				if lib.check_rule(entity1, entity2) then
					local p1 = rpo[entity1] or lib.rotate_poly(entity1)
					local p2 = rpo[entity2] or lib.rotate_poly(entity2)
					rpo[entity1] = p1
					rpo[entity2] = p2

					-- polygon collision
					collided = lib.polygon_in_polygon(p1, p2, entity1.position, entity2.position)

					-- Actual logic
					if collided then
						lib.execute_if_rule(entity1, entity2, s.prev[entity1])
					end
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


s.registers = {}
s.registers.collision = function(entity)
	if entity.collision.box then
		lib.aabb_around(entity, s.boxes)
	else
		lib.circle_around(entity, s.circles)
	end
	
	s.prev[entity] = {x = entity.position.x, y = entity.position.y,  rotation = entity.position.rotation}
end


s.unregisters = {}
s.unregisters.collision = function(entity)
	print("Static  collision entity removed")
	s.circles[entity] = nil
	s.prev[entity] = nil

end


lib.add_rule("test", "test", core.DoAll(lib.trivial_solve, reverser))
return s
