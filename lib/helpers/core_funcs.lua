-- Contains some higher-order functions.
-- Not really in use right now, might be of use later.
core = core or {}
core.events = core.events or {}
core.And = function(cfuncs)
    return function()
        for k, v in ipairs(cfuncs) do
            if not v() then
                return false
            end
        end
        return true
    end
end

local loaded_paths = {}
core.my_require = function(str)
    loaded_paths[str] = str
    return require(str)
end
core.un_require = function()
    for k, v in pairs(loaded_paths) do
        package.loaded[v] = nil
    end
end
core.Or = function(cfuncs)
    return function()
        for k, v in ipairs(cfuncs) do
            if v() then
                return true
            end
        end
        return false
    end
end

core.Not = function(cfunc)
    return function()
        return not cfunc()
    end
end


core.While = function(cfunc, func)
    return function(dt)
        if cfunc(dt) then
            func(dt)
        end
    end
end


core.When = function(cfunc, func)
    local a = false
    return function(dt)
        if cfunc(dt) then
            if not a then
                func(dt)
            end
            a = true
        else
            a = false
        end
    end
end


core.PreFill = function(a, ...)
    local b = { ... }
    return function(...)
        local z = {}
        for k, v in ipairs(b) do
            z[#z + 1] = v
        end
        for k, v in ipairs({ ... }) do
            z[#z + 1] = v
        end
        return a(unpack(z))
    end
end


core.Chain = function(a, ...)
    a(...)
    return ...
end


core.DoAll = function(...)
    local b = { ... }

    return function(...)
        for k, v in ipairs(b) do
            v(...)
        end
    end
end

core.rotate_point = function(p, angle)

    local s = math.sin(angle)
    local c = math.cos(angle)

    -- rotate point
    local xnew = p.x * c - p.y * s
    local ynew = p.x * s + p.y * c

    -- translate point back:
    return { x = xnew, y = ynew }
end