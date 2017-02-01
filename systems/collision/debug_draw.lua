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
	for k,v in pairs (CIRC) do
		love.graphics.circle("line", k.position.x, k.position.y, v )
	end
end
s.registers = {}
s.unregisters = {}

return s
