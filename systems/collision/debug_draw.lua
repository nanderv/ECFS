-- Draw debug shapes of the collision system.
local s = {}


s.functions = {}
s.functions.draw = function(dt)
	local i = 1	
	for _,v in ipairs(E.collision) do
		i = i + 1
		if i > 20 then
			break
		end
		local arr = {}
		for _,w in ipairs(v.collision.polygon) do
			local x = core.rotate_point(w, v.position.rotation)
			arr[#arr+1] = x.x+ v.position.x
			arr[#arr+1] = x.y+ v.position.y
		end
			local x = core.rotate_point(v.collision.polygon[1], v.position.rotation)

		arr[#arr+1] = x.x + v.position.x
		arr[#arr+1] = x.y + v.position.y
		love.graphics.polygon("fill", unpack(arr))
	end
	local i = 1	

	for k,v in pairs (CIRC) do
		if i > 20 then
			break
		end
		i=i+1
		love.graphics.circle("line", k.position.x, k.position.y, v )
	end
	local i = 1	

	for k,v in pairs (BOXES) do
		i=i+1
		if i > 20 then
			break
		end
		love.graphics.rectangle("line", k.position.x + v.minx, k.position.y + v.miny, v.maxx - v.minx, v.maxy - v.miny)
	end
end

s.registers = {}
s.unregisters = {}

return s
