-- Draw debug shapes of the collision system.
local s = function(dt)
	if not E.collision then
		return
	end
	for _,v in ipairs(E.collision) do
		local arr = {}
		for _,w in ipairs(v.collision.polygon) do
			local x = core.rotate_point(w, v.position.rotation)
			arr[#arr+1] = x.x + v.position.x
			arr[#arr+1] = x.y + v.position.y
		end
			local x = core.rotate_point(v.collision.polygon[1], v.position.rotation)
		arr[#arr+1] = x.x + v.position.x
		arr[#arr+1] = x.y + v.position.y
		love.graphics.polygon("fill", unpack(arr))
	end
end 

return s
