local handlers = { type = "list" }
core.newHandler = function(name, doWhen, run)
    return { name = name, doWhen = doWhen, run = run, type = "handler" }
end
core.addHandler = function(handler)
    handlers[#handlers + 1] = handler
    handler.id = #handlers
    return id
end
core.removeHandler = function(handler)
    handlers[handler.id] = nil
end
core.findHandlerFromSublist = function(name, h)
    if h.name == name then
        return h
    end
    if (type(h.run) == "table" and h.run.type == "handler") then
        local found = core.findHandlerFromSublist(name, v.run)
        if found then
            return found
        end
    elseif (type(h) == "table" and h.type == "list") then
        for _, w in ipairs(h) do
            local found = core.findHandlerFromSublist(name, w)
            if found then
                return found
            end
        end
    end
end

core.findHandler = function(name)
    return core.findHandlerFromSublist(name, handlers)
end
core.runEventFromSublist = function(event, h)
    if h.type == "handler" then
        if h.doWhen(event) then
            if type(h.run) == "function" then
                h.run(event)
            else
                core.runEventFromSublist(event, h.run)
            end
        end
    elseif h.type == "list" then
        for _, v in ipairs(h) do
            core.runEventFromSublist(event, v)
        end
    end
end
core.runEvent = function(event)
    core.runEventFromSublist(event, handlers)
end
