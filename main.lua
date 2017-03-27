pprint = require 'lib.pprint'
require 'lib.helpers.core_funcs'
require 'lib.helpers.keyboard_input'
require 'lib.ECFS'
require 'lib.load_all_scripts'

function love.load()
	require 'scripts'
	scripts.systems.collision.init.functions.reset()
	core.system.add(scripts.systems.collision.init)
	ent = {LW={}, collision = {dynamic=true, box=true, type="test", polygon = {{x=-50,y=-50},{x=50,y=-50},{x=50,y=500},{x=-50,y=500}}}, position = {x=630, y=290, rotation=0}}
	core.entity.add (ent)
	local ent = {light={minRot=0, maxRot=0.5*math.pi,dist=300}, collision = {type="test", box=true, polygon = {{x=-100,y=0},{x=0,y=100},{x=100,y=0},{x=0,y=-100}}, dynamic = true}, position = {x=250, y=250, rotation=0}}
	core.entity.add (ent)
	local wasdplayer1 = scripts.handlers.print_onmove(ent)
	core.addHandler(wasdplayer1.name, wasdplayer1.func)

	local handler2 = scripts.handlers.handle_wisker()
	core.addHandler(handler2.name, handler2.func)
	pprint(handler2)

	local c = {type="test", box=true, polygon = {{x=-100,y=0},{x=0,y=100},{x=100,y=0},{x=0,y=-100}}, dynamic = true}
	local ent = {collision = nil, position = {x=250, y=250, rotation=0}, wiskers={{x=100,y=100},{x=-100,y=100}}}
	core.entity.add (ent)
end

function love.update(dt)
	scripts.handle_fetch_threading(dt)
	scripts.handle_input()
	scripts.handle_pre_world_update(dt)
	scripts.world_update(dt)
	scripts.handle_checkers(dt)
end

function love.draw()
	scripts.systems.collision.debug_draw(dt)
	scripts.systems.draw_wiskers(dt)
	love.graphics.print(love.timer.getFPS(), 10,10)
	love.graphics.print(collectgarbage('count'), 50,10)
end
