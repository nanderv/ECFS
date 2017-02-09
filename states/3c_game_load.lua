-- This state is responsible for setting the game up, based on the current loaded gamestate. It ensures all data for all objects is properly loaded.

local GS = require 'lib.gamestate'

local ctx = GS.new()
local GAMELOOP = require 'states.4_gameloop'
function ctx:enter(from)
  ctx.from = from -- record previous state
  core.events = {}
	require 'filters'

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
	Gamestate.switch(GAMELOOP)
end

function ctx:leave()
end

function ctx:update(dt)

end

function ctx:draw()

  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  love.graphics.setColor(5, 5, 5,180)
  love.graphics.rectangle("fill",0,0,width,height)
  love.graphics.setColor(255,255,255,255)
 
end

return ctx