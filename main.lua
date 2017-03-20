pprint = require 'lib.pprint'
require 'helpers.core_funcs'
require 'lib.ECFS'
require 'lib.load_all_scripts'


function love.load()
	require 'scripts'
	scripts.systems.collision.init.functions.reset()
	core.system.add(scripts.systems.collision.init)

	local ent = {keyboardcontrols = true, collision = {type="test", box=true, polygon = {{x=-100,y=0},{x=0,y=100},{x=100,y=0},{x=0,y=-100}}, dynamic = true}, position = {x=250, y=250, rotation=0}}
	core.entity.add (ent)

	ent = {collision = {box=true, type="test", polygon = {{x=-50,y=-50},{x=50,y=-50},{x=50,y=500},{x=-50,y=500}}}, position = {x=630, y=290, rotation=0}}
	core.entity.add (ent)

end


function love.update(dt)
	scripts.handle_fetch_threading()
	scripts.handle_input()
	scripts.handle_pre_world_update()
	scripts.world_update(dt)
	scripts.handle_post_world_update()
	scripts.handle_checkers()
end
function love.draw()
	scripts.systems.collision.debug_draw(dt)
	love.graphics.print(love.timer.getFPS(), 10,10)
	love.graphics.print(collectgarbage('count'), 50,10)
end
