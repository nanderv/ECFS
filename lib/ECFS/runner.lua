-- The runner is responsible for executing a certain piece of logic on all entities of a certain filter

-- filter: String   - The name of the filter
-- funct : Function - The function to be executed on all entities that pass a certain filter
-- args  : Table    - Table of arguments for runner

-- Return values: two booleans: update, delete
core.run = function(filter, funct, args)
    local l = E[filter]
    for _,v in ipairs(l) do
        local o, p = funct(v, args)
        if p then
            core.entity.remove(v)
        elseif o then
            core.filter.update(v)
        end
    end
end