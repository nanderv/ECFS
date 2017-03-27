return function(dt)
	COLS = {}
	for k,v in pairs(E.wiskers) do
		local sx = v.position.x
		local sy = v.position.y
		love.graphics.circle("line",v.position.x, v.position.y, 10)
		local a = {}
		for l,w in ipairs(v.wiskers) do
			local aa, b, c = scripts.systems.collision.init.ray(v, {x=0,y=0}, {x=w.x, y=w.y})
			a[w] = {entity=a, x=b, y=c}
		end

		core.add_event("pre",scripts.events.create_wisker_collision_event(v, a))
	end
	
end