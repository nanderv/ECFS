
return function(dt)
    core.run("move", scripts.systems.controls.wasd, { dt = dt })
    scripts.systems.collision.collision.functions.update(dt)

end