-- Pause screen.

-- This file is responsible for pausing!!!

local GS = require 'lib.gamestate'

-- {{render = function(), chooser = function(), executer = function()}}
local ctx = GS.new()
local function a ()
	local GAMELOOP = require 'states.4_gameloop'
	core.Rem_Events("UNPAUSE","UNPAUSE")

	Gamestate.push(GAMELOOP)
end
function ctx:enter(from)

  ctx.from = from -- record previous state
  aa = false  
  print("PAUSE")
	core.keyboard.whenDown("UNPAUSE", "UNPAUSE", "escape", a)

end

function ctx:leave()
  
end

function ctx:update(dt)
	      -- This looks like lots of loops, but it really isn't .

    dt = 0
    ctx.from.update(0)


end

function ctx:draw()
	ctx.from.draw()

	if core.system.functions.draw then
		for _,v in pairs(core.system.functions.draw)do
			v.functions.draw()
		end
	end
end

return ctx
