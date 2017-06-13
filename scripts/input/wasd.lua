local events = {}
local Down = core.keyboard.isDown

local a = function(evt)
    events[evt] = evt
end
a(core.While(Down("w"), core.PreFill(core.add_event, "pre", scripts.events.on_move_event(nil, { x = 0, y = -100 }))))
a(core.While(Down("d"), core.PreFill(core.add_event, "pre", scripts.events.on_move_event(nil, { x = 100, y = 0 }))))
a(core.While(Down("s"), core.PreFill(core.add_event, "pre", scripts.events.on_move_event(nil, { x = 0, y = 100 }))))
a(core.While(Down("a"), core.PreFill(core.add_event, "pre", scripts.events.on_move_event(nil, { x = -100, y = 0 }))))


return function(dt)
    for k, v in pairs(events) do
        v(dt)
    end
end