local s = {}
s.functions = {}
local prevposses = {}

s.functions.update = function(dt)
    for k, v in ipairs(E.relative_position) do
        v.relativeto.position = { x = v.relativeto.position.x + v.position.x - prevposses[v].x, y = v.relativeto.position.y + v.position.y - prevposses[v].y, rotation = v.position.rotation - prevposses[v].rotation }
        local p = core.get_entity(v.relativeto.id).position
        v.position = { x = p.x + v.relativeto.position.x, y = p.y + v.relativeto.position.y, rotation = p.rotation + v.position.rotation }
        prevposses[v] = v.position
    end
end

s.functions.reset = function()
    prevposses = {}
end
s.registers = {}
s.registers.relative_position = function(entity)
    local x = core.get_entity(entity.relativeto.id).position
    entity.position = { x = x.x + entity.relativeto.position.x, y = x.y + entity.relativeto.position.y, rotation = x.rotation + entity.relativeto.position.rotation }
    prevposses[entity] = { x = x.x, y = x.y, rotation = x.rotation }
end


s.unregisters = {}
s.unregisters.relative_position = function(entity)
    prevposses[entity] = nil
end
s.update = s.functions.update
s.reset = s.functions.reset
s.paused = false
s.name = "relative_collision"
return s