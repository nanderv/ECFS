local s = {}
local lib = require 'systems.collision.lib'
s.functions = {}
s.circles = {}
CIRC = s.circles
local rpo = {}
s.prev = {}

local function checkCollision (entity1)
	for _,entity2 in ipairs(E.collision) do
		if entity1 ~= entity2  then
			local dx = entity1.position.x - entity2.position.x
			local dy = entity1.position.y - entity2.position.y
			local distSQ = math.sqrt(dx * dx + dy * dy)
			-- Trivial check: check if squared distances are similar
			
			if distSQ < (s.circles[entity1] + s.circles[entity2])  then
				print("HERE")
				-- Check if the collision is necessary. I think this is slightly slower than the previous check, so that's why this one is later. Not tested.
				if lib.check_rule(entity1, entity2) then
				local p1 = rpo[entity1] or lib.rotate_poly(entity1)
				local p2 = rpo[entity2] or lib.rotate_poly(entity2)
				rpo[entity1] = p1
				rpo[entity2] = p2
				pprint(p1)
				pprint(p2)
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
	entity1.mover.x = -entity1.mover.x
	entity1.mover.y = -entity1.mover.y
	entity1.mover.rotation = -entity1.mover.rotation
end
lib.add_rule("test", "test", core.DoAll(lib.trivial_solve, reverser))
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
	print("Static  collision entity added")
	print(lib.circle_around(entity, s.circles))
	s.prev[entity] = {x = entity.position.x, y = entity.position.y,  rotation = entity.position.rotation}
end

s.unregisters = {}
s.unregisters.collision = function(entity)
	print("Static  collision entity removed")

end

return s
