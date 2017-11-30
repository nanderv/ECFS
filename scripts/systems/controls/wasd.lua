return function(entity, args)
    local dt = args.dt
    entity.position.x = entity.position.x + 1
    return true, false
end