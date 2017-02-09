local GS = require 'lib.gamestate'
local ctx = GS.new()
local SETTINGS = require 'states.2a_settings'
local HELP = require 'states.2b_help'
local INIT = require 'states.3a_game_init'
function ctx:enter(from)
  ctx.from = from -- record previous state
  core.events = {}
core.keyboard.whenDown(ctx, "A", "1", core.PreFill(Gamestate.switch, INIT))
core.keyboard.whenDown(ctx, "A", "2", core.PreFill(Gamestate.switch, SETTINGS))
core.keyboard.whenDown(ctx, "A", "3", core.PreFill(Gamestate.switch, HELP))

  print("MENU")
end
function ctx:leave()
  	core.events = {}

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
  love.graphics.print("1. Start", 300,100)
  love.graphics.print("2. Settings", 300,120)
    love.graphics.print("3. Help", 300,140)

end


return ctx