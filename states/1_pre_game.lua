local GS = require 'lib.gamestate'
local MENU = require 'states.2_menu'
local ctx = GS.new()


core = core or {}
core.events = core.events or {}
function ctx:enter(from)
	core.keyboard.whenDown(ctx, "A", "a", core.PreFill(Gamestate.switch, MENU))
  resources = {}
  
  print("ENTERING MENU")


end
function ctx:leave()
  
end
function ctx:update(dt)

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


function ctx:draw()
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  love.graphics.setColor(5, 5, 5,180)
  love.graphics.rectangle("fill",0,0,width,height)
  love.graphics.setColor(255,255,255,255)
end


return ctx

