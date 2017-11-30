scripts = scripts or {}
local collision_update = scripts.systems.collision.collision.functions.update

scripts.world_update = function(dt)
    core.run("move", scripts.systems.controls.wasd, { dt = dt })
    collision_update(dt)
end

