-- This one is responsible for setting up the game data context. It's intended for clearing all data.
local GS = require 'lib.gamestate'

local ctx = GS.new()
local SETUP = require 'states.3b_setup'
function ctx:enter(from)
  -- restart the entire gamestate
  for k, v in pairs(core.systems) do
    core.system.remove(v)
  end
  for k, v in ipairs(E.A) do
    core.entity.remove(v)
  end
  
  core.filter.rules = {}
  F = {}
  

  E = {} -- E is the entity lists, so E.walls is going to contain all walls.
  F = {} -- F is the entity list, but as a dictionary 
  R = {}

  --  Clear events
  core.events = {}
  core.keyboard.whenDown(ctx, "A", "a", core.DoAll(core.PreFill(Gamestate.switch, SETUP), core.PreFill(print, "LEAVING")))

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

end

return ctx
	