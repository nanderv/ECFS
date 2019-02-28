local clickOn = {}

clickOn.clickArea = function(x, y, w, h)
    return function(event)
        return (event.x > x and event.y > y and event.x < x + w and event.y < y + h)
    end
end

clickOn.findAllClickableObjects = function(filter)
    return function(event)
        local objs = {}
        for k, v in ipairs(E[filter]) do
            if scripts.systems.collision.lib.point_in_polygon(v.collision.polygon, { x = event.x, y = event.y }, v.position, { x = 0, y = 0 }) then
                objs[#objs + 1] = v
            end
        end
        return objs
    end
end

clickOn.filterObjects = function(func, filterFunc)
    return function(event)
        local objs = func(event)
        local result = {}
        for _, v in pairs(objs) do
            if filterFunc(v) then
                result[#result + 1] = v
            end
            return result
        end
    end
end

clickOn.print = function(func)
    return function(event)
        pprint(func(event))
    end
end

return clickOn