require 'ECFS'

require 'filters'
local fun = require'lib.fun'
function love.load()
	core.system.add(require 'systems.test')
	local entity1 = {position = {1,1}, engine={}}
	core.entity.add(entity1)
	core.entity.remove(entity1)

end
function love.draw()
	if core.system.functions.draw then
		for _,v in pairs(core.system.functions.draw)do
			v.functions.draw()
		end
	end
end

function reverse(map)
	return fun.foldl(function(acc, x) return fun.op.insert(acc, x, map[x]) end, {},  fun.op.keys(map))
end
function love.update()
	print (reverse({a="b"}))
	for _,v in pairs(core.system.functions.update)do
		v.functions.update(dt)
	end
end
