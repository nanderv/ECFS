-- Draw debug shapes of the collision system.
local s = {}


s.functions = {}
s.functions.draw = function(dt)
	
	for _,v in ipairs(E.collision) do
		
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

end 

s.registers = {}
s.unregisters = {}

return s
