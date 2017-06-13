local function get_is_lighting_object(obj)
    return F.light_wall[obj]
end

return function()
    local world = scripts.systems.collision.init.get_world()

    world:querySegment(0, 0, 1000, 1000, get_is_lighting_object)
end