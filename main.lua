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
    local ent = { clickable=true, mover=100,light = { minRot = 0, maxRot = 0.5 * math.pi, dist = 300 }, collision = { type = "test", box = true, polygon = { { x = -100, y = 0 }, { x = 0, y = 100 }, { x = 100, y = 0 }, { x = 0, y = -100 } }, dynamic = true }, position = { x = 250, y = 250, rotation = 0 } }
    core.entity.add(ent)

    ent = { collision = nil, position = { x = 250, y = 250, rotation = 0 }, wiskers = { { x = 100, y = 100 }, { x = -100, y = 100 } } }
    core.entity.add(ent)
    local h1 = core.newHandler("mouse", function(event) return event.type=="mouseclick" end, {type = "list"})

    local co =  scripts.handlers.clickOn
    local handler = core.newHandler("test",co.clickArea(100,100,400,400), co.print(co.findAllClickableObjects("clickable")))
    h1.run[1] = handler
    core.addHandler(h1)
     h1 = core.newHandler("keys", function(event) return event.type=="key" end, {type = "list"})

    handler = core.newHandler("RELOAD", function(event) return event.key=="f9" end, RELOADALL)
    core.addHandler(h1)
    h1.run[1] = handler

    pprint(core.findHandler("test"))

end

function love.update(dt)
    scripts.main.mainloop(dt)
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
function love.keypressed( key, scancode, isrepeat )
    core.runEvent({key=key, scancode=scancode,isrepeat=isrepeat,type="key"})
end