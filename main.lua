
CONFIG = {}
UI_STATE = {}
SUPERSTATE = {} -- Superstate = the all game-information 
pprint = require 'lib.pprint'

require 'helpers.core_funcs'
require 'ECFS'
require 'inputoutput.keyboard_input'
STATES = {}
Gamestate = require 'lib.gamestate'
STATES[1] = require 'states.1_pre_game'

function love.load()
    Gamestate.registerEvents()
 	Gamestate.switch(STATES[1])
	


end
function love.draw()

	love.graphics.print(love.timer.getFPS(), 10,10)
	love.graphics.print(collectgarbage('count'), 50,10)
end

function reverse(map)
	return fun.foldl(function(acc, x) return fun.op.insert(acc, map[x], x) end, {},  fun.op.keys(map))
end
function love.update(dt)
	--- Events


end
