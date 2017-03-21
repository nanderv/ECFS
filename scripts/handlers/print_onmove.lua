return function(entity) 
	return{name="onMove", func = function(event, dt)
		entity.position.x = entity.position.x + dt * event.data.x
		entity.position.y = entity.position.y + dt * event.data.y
 		end
	}
end