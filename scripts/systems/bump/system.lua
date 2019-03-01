-- Collision system
return function()
    local s = {}
    local bump = require 'lib.bump'
    local WORLD = bump.newWorld(50)
    s.functions = {}
    s.get_WORLD = function()
        return WORLD
    end


    s.functions.reset = function()
        WORLD = bump.newWorld(50)
    end
    s.functions.update = function()

    end
    s.registers = {}
    s.registers.collision = function(entity)
        WORLD:add(entity, x - width /2, y -width/2, width, height)
    end

    s.unregisters = {}
    s.unregisters.collision = function(entity)
        print("Static  collision entity removed")
        WORLD:remove(entity)
    end

    s.update = s.functions.update
    s.reset = s.functions.reset
    s.paused = true
    s.name = "bump"
    return s
end