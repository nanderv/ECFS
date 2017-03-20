-- A system that applies a constant movement to an object.
return  function(dt)
	if not E.move then
		return
	end
	dt = dt 
	for k,v in ipairs(E.move) do 
		v.position.x = v.position.x + dt * v.mover.x
		v.position.y = v.position.y + dt * v.mover.y
		v.position.rotation = v.position.rotation + dt * v.mover.rotation
	end
end

