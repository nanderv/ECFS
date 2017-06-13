core.entity = {}

local unregisters = core.system.unregisters

-- This is awesome. Think about it, you will understand why ;).
core.entity.add = core.filter.update

function core.entity.remove(entity)
    local R = core.filter.rules
    local id = entity_to_id[entity]
    entity_to_id[entity] = nil
    id_to_entity[id] = nil
    for _, name_rules in pairs(R) do
        local name = name_rules[1]
        local ind = F[name][entity]

        if ind then
            E[name][ind] = E[name][#E[name]]
            E[name][#E[name]] = nil
            F[name][entity] = nil
            if unregisters[name] then
                for _, v in pairs(unregisters[name]) do
                    v.unregisters[name](entity)
                end
            end
        end
    end
end
