return function(dt)
	COLS = {}
	for k,v in pairs(E.wiskers) do
		local sx = v.position.x
		local sy = v.position.y
		love.graphics.circle("line",v.position.x, v.position.y, 10)
		for l,w in ipairs(v.wiskers) do
			scripts.systems.collision.init.ray(v, {x=0,y=0}, {x=w.x, y=w.y})
		end
	end
	for k,v in pairs(E.wiskers) do
	end
end