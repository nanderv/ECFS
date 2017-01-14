require 'ECFS'

require 'filters'

function love.load()
	local entity1 = {position = {1,1}, engine={}}
	core.entity.add(entity1)
	print(#E.A)
end
function love.draw()
	for _,v in ipairs(core.system.functions.update)do
		v.draw()
	end
end

function love.update()
	for _,v in ipairs(core.system.functions.update)do
		v.update(dt)
	end
end