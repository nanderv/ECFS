love.math.setRandomSeed( 300 )
math.random()
math.random()
math.random()

pprint = require 'lib.pprint'

require 'helpers.core_funcs'
require 'ECFS'
require 'filters'

fun = require'lib.fun'
function love.load()
	core.system.add(require 'systems.test')
	core.system.add(require 'systems.collision')
	core.system.add(require 'systems.collision.debug_draw')

	core.system.add(require 'systems.simple_move')

	local ent = {collision = {type="test", polygon = {{x=-100,y=0},{x=0,y=100},{x=100,y=0},{x=0,y=-100}}, dynamic = true}, position = {x=250, y=250, rotation=0}, mover = {x=100, y=0, rotation =  1}}
	core.entity.add (ent)
	ent = {collision = {type="test", polygon = {{x=-100,y=0},{x=0,y=100},{x=100,y=0},{x=0,y=-100}}}, position = {x=440, y=290, rotation=0}}
	core.entity.add (ent)
	ent = {collision = {type="test", polygon = {{x=-100,y=0},{x=0,y=100},{x=100,y=0},{x=0,y=-100}}}, position = {x=0, y=290, rotation=0}}
	core.entity.add (ent)


end
function love.draw()
	if core.system.functions.draw then
		for _,v in pairs(core.system.functions.draw)do
			v.functions.draw()
		end
	end
end

function reverse(map)
	return fun.foldl(function(acc, x) return fun.op.insert(acc, map[x], x) end, {},  fun.op.keys(map))
end
function love.update(dt)
	if core.system.functions.update then
		for _,v in pairs(core.system.functions.update)do
			v.functions.update(dt)
		end
	end
end
