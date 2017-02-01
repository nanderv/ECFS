local s = {}
s.functions = {}
s.functions.update = function(dt)
	dt = dt / 40
	for k,v in ipairs(E.move) do 
		v.position.x = v.position.x + dt * v.mover.x
		v.position.y = v.position.y + dt * v.mover.y
		v.position.rotation = v.position.rotation + dt * v.mover.rotation
	end
end
s.registers = {}
s.unregisters = {}

return s
