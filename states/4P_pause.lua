-- Pause screen.

-- This file is responsible for pausing!!!

local GS = require 'lib.gamestate'

-- {{render = function(), chooser = function(), executer = function()}}
local ctx = GS.new()
local function a ()
	local GAMELOOP = require 'states.4_gameloop'
	core.Rem_Events("UNPAUSE","UNPAUSE")

	Gamestate.pop()
	Gamestate.switch(GAMELOOP)
end
local function b()
	local MENU = require 'states.2_menu'
	core.Rem_Events("UNPAUSE","UNPAUSE")

	Gamestate.pop()
	Gamestate.switch(MENU)
end
function ctx:enter(from)

  ctx.from = from -- record previous state
  aa = false  
  print("PAUSE")

	core.keyboard.whenDown("UNPAUSE", "UNPAUSE", "escape", a)
	core.keyboard.whenDown("UNPAUSE", "UNPAUSE", "1", b)

end

function ctx:leave()
  
end

function ctx:update(dt)
  -- This looks like lots of loops, but it really isn't .
    ctx.from:update(0)
end

function ctx:draw()
	ctx.from.draw()
	love.graphics.setColor(0,0,0,128)
	love.graphics.rectangle("fill",0,0,love.graphics.getWidth( ),love.graphics.getHeight( ))
	love.graphics.setColor(255,255,255,255)
	love.graphics.print("Press esc to continue playing",255,255)
end

return ctx
