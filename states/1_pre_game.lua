local GS = require 'lib.gamestate'
local ctx = GS.new()

function ctx:enter(from)
  resources = {}
  
end
function ctx:leave()
  
end
function ctx:update(dt)
  	for k,v in pairs(core.events) do
		for l,w in pairs(v) do
			for m,x in ipairs(w) do
				x(dt)
			end
		end
	end
end


function ctx:draw()
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  love.graphics.setColor(5, 5, 5,180)
  love.graphics.rectangle("fill",0,0,width,height)
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(get_image(note_image),width/2-(get_image(note_image):getWidth()/2),height/2-(get_image(note_image):getHeight()/1.8))
end


return ctx

