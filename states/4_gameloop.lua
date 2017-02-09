-- This file is responsible for the normal main gameloop. Some games may have more than one gameloop if the loops are too different.

local GS = require 'lib.gamestate'

-- {{render = function(), chooser = function(), executer = function()}}
local ctx = GS.new()
local function a ()
	local PAUSE = require 'states.4P_pause'
	core.Rem_Events("PAUSE","PAUSE")
	Gamestate.push(PAUSE)
end

function ctx:enter(from)
	ctx.from = from -- record previous state
	aa = false  
	print("ADDING GAMELOOP")
	core.keyboard.whenDown("PAUSE", "PAUSE", "escape", a)
end

function ctx:leave()
  
end

function ctx:update(dt)
	if not dt then
		dt = 0
	end
	      -- This looks like lots of loops, but it really isn't .
    for k,v in pairs(core.events) do
      for l,w in pairs(v) do
        for m,x in ipairs(w) do
          x(dt)
        end
      end
    end
	if core.system.functions.update then
		for _,v in pairs(core.system.functions.update)do
			v.functions.update(dt)
		end
	end

end

function ctx:draw()

	if core.system.functions.draw then
		for _,v in pairs(core.system.functions.draw)do
			v.functions.draw()
		end
	end
end

return ctx
