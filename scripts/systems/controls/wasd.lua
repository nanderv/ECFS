return function(entity, args)
    local dt = args.dt

    if love.keyboard.isDown("a") then
        entity.position.x = entity.position.x - entity.mover * dt
    elseif love.keyboard.isDown("d") then
        entity.position.x = entity.position.x + entity.mover * dt
    end
    if love.keyboard.isDown("w") then
        entity.position.y = entity.position.y - entity.mover * dt
    elseif love.keyboard.isDown("s") then
        entity.position.y = entity.position.y + entity.mover * dt
    end
    return true, false
end