-- This stage is responsible for setting up things like character selection etc. Think of it as setting up the initial game state.
local GS = require 'lib.gamestate'
local LOAD = require'states.3c_game_load'
local ctx = GS.new()

function ctx:enter(from)
  ctx.from = from -- record previous state
  core.events = {}
  print("SETUP")
  core.keyboard.whenDown(ctx, "A", "1", core.DoAll(core.PreFill(Gamestate.switch, LOAD), core.PreFill(print, "LEAVING")))

end

function ctx:leave()
    core.events = {}
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
end

function ctx:draw()

  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  love.graphics.setColor(5, 5, 5,180)
  love.graphics.rectangle("fill",0,0,width,height)
  love.graphics.setColor(255,255,255,255)
    love.graphics.print("No character setup needed", 300,250)

  love.graphics.print("Press 1 to start", 300,300)
 
end

return ctx
	
