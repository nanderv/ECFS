pprint = require 'lib.pprint'
require 'lib.helpers.core_funcs'
require 'lib.ECFS'
require 'lib.load_all_scripts'
local handling = require 'lib.UI.handling'
require 'lib.UI.ui_data_state'

function addStates()
    print( scripts.states.testPage())
    handling.addState("menu", scripts.states.testPage())
    handling.addState("subMenu", {prevState= "menu"})
    UIDATASTATE.PUT({"a", "b"}, 3)
    pprint(UIDATASTATE.GET({}))
end
function love.load()
    require 'scripts'
    addStates()

end

function love.update(dt)
    handling.update(dt)
end

function love.draw()
    handling.draw()
end

function love.mousepressed( x, y, button )
    handling.mousePressed(x,y, button)
end
function love.keypressed( key, scancode, isrepeat )
    handling.keypressed( key, scancode, isrepeat )
end