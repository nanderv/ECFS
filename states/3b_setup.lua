-- This stage is responsible for setting up things like character selection etc. Think of it as setting up the initial game state.
local GS = require 'lib.gamestate'

local ctx = GS.new()

function ctx:enter(from)
  ctx.from = from -- record previous state
  aa = false  
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
  
	for k,v in pairs(data) do
		v.render()	  		
	end
end

return ctx
	
