
CONFIG = {}
UI_STATE = {}
SUPERSTATE = {} -- Superstate = the all game-information 
pprint = require 'lib.pprint'

require 'helpers.core_funcs'
require 'ECFS'
require 'filters'
require 'inputoutput.keyboard_input'
fun = require'lib.fun'

function love.load()

	core.system.add(require 'systems.test')
	core.system.add(require 'systems.collision')
	core.system.add(require 'systems.collision.debug_draw')
	core.system.add(require 'systems.input.keyboard')
	core.system.add(require 'systems.simple_move')

	local ent = {keyboardcontrols = true, collision = {type="test", box=true, polygon = {{x=-100,y=0},{x=0,y=100},{x=100,y=0},{x=0,y=-100}}, dynamic = true}, position = {x=250, y=250, rotation=0}}
	core.entity.add (ent)

	ent = {collision = {box=true, type="test", polygon = {{x=-50,y=-50},{x=50,y=-50},{x=50,y=500},{x=-50,y=500}}}, position = {x=630, y=290, rotation=0}}
	core.entity.add (ent)
	for k = 0, 40 do
	ent = {collision = {type="test",
						 box=true, dynamic=false,
						 polygon = {
							 {x=-100,y=0},
							 {x=0,y=100},
							 {x=100,y=0},
							 {x=0,y=-100}}},
						 position = {x=0, y=290+200*k, rotation=0}}
	core.entity.add (ent)
	end


end
function love.draw()
	if core.system.functions.draw then
		for _,v in pairs(core.system.functions.draw)do
			v.functions.draw()
		end
	end
	
	love.graphics.print(love.timer.getFPS(), 10,10)
	love.graphics.print(collectgarbage('count'), 50,10)
end

function reverse(map)
	return fun.foldl(function(acc, x) return fun.op.insert(acc, map[x], x) end, {},  fun.op.keys(map))
end
function love.update(dt)
	--- Events

	-- This looks like lots of loops, but it really isn't .
	for k,v in pairs(core.events) do
		for l,w in pairs(v) do
			for m,x in ipairs(w) do
				x(dt)
			end
		end
	end

	-- update functions
	if core.system.functions.update then
		for _,v in pairs(core.system.functions.update) do
			v.functions.update(dt)
		end
	end
end
