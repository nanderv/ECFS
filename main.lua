pprint = require 'lib.pprint'
require 'lib.helpers.core_funcs'
require 'lib.ECFS'
require 'lib.load_all_scripts'

function love.load()
    require 'scripts'
    scripts.systems.collision.collision.functions.reset()
    core.system.add(scripts.systems.collision.collision)
    local ent = { LW = {}, collision = { dynamic = true, box = true, type = "test", polygon = { { x = -50, y = -50 }, { x = 50, y = -50 }, { x = 50, y = 500 }, { x = -50, y = 500 } } }, position = { x = 630, y = 290, rotation = 0 } }
    core.entity.add(ent)
    local ent = { mover=100,light = { minRot = 0, maxRot = 0.5 * math.pi, dist = 300 }, collision = { type = "test", box = true, polygon = { { x = -100, y = 0 }, { x = 0, y = 100 }, { x = 100, y = 0 }, { x = 0, y = -100 } }, dynamic = true }, position = { x = 250, y = 250, rotation = 0 } }
    core.entity.add(ent)

    ent = { collision = nil, position = { x = 250, y = 250, rotation = 0 }, wiskers = { { x = 100, y = 100 }, { x = -100, y = 100 } } }
    core.entity.add(ent)
    local handler = core.newHandler("test", scripts.handlers.clickOn.clickArea(100,100,400,400), pprint)
    core.addHandler(handler)
    pprint(core.findHandler("test"))

end

function love.update(dt)
    scripts.world_update(dt)
end

function love.draw()
    scripts.systems.collision.debug_draw(dt)
    core.run("wiskers", scripts.systems.draw_wiskers, {dt=dt})
    love.graphics.print(love.timer.getFPS(), 10, 10)
    love.graphics.print(collectgarbage('count'), 50, 10)
end
function love.mousepressed( x, y, button )
    core.runEvent({x = x, y = y, button = button, type = "mouseclick"})
end