return function(dt)
	for k,v in pairs(E.wiskers) do
		local sx = v.position.x
		local sy = v.position.y
		love.graphics.circle("line",v.position.x, v.position.y, 10)
		for l,w in ipairs(v.wiskers) do
			love.graphics.line(sx, sy, w.x+sx, sy+w.y)
		end
		for l,w in ipairs(COLS) do
			love.graphics.circle("line",w.x, w.y, 30)
		end
	end
end