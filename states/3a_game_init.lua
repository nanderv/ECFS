local GS = require 'lib.gamestate'

local ctx = GS.new()

function ctx:enter(from)
  -- restart the entire gamestate
  for k, v in pairs(core.systems) do
    core.system.remove(v)
  end
  for k, v in pairs(R)  do
    core.filter.remove(v)
  end
  for k, v in ipairs(E.A) do
    core.entity.remove(v)
  end
  E = {} -- E is the entity lists, so E.walls is going to contain all walls.
  F = {} -- F is the entity list, but as a dictionary 
  R = {}
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
	