pprint = require 'lib.pprint'
require 'lib.helpers.core_funcs'
require 'lib.ECFS'
require 'lib.load_all_scripts'
local state = require 'lib.UI.state'

function addStates()
    print( scripts.states.testPage())
    state.addState("menu", scripts.states.testPage())
    state.addState("subMenu", {prevState= "menu"})
end
function love.load()
    require 'scripts'
    addStates()

end

function love.update(dt)
    state.update(dt)
end

function love.draw()
    state.draw()
end

function love.mousepressed( x, y, button )
    state.mousePressed(x,y, button)
end
function love.keypressed( key, scancode, isrepeat )
    state.keypressed( key, scancode, isrepeat )
end