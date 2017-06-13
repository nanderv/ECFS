core.system = {}
core.system.registers = {}
core.system.unregisters = {}
local registers = core.system.registers
local unregisters = core.system.unregisters
core.systems = {}
core.system.add = function(system)

    -- Add functionality of system to respected lists
    core.systems[system] = system

    -- Add system to register lists

    if system.registers then
        -- k is the name of a filter
        for k, v in pairs(system.registers) do
            if not registers[k] then
                registers[k] = {}
            end
            registers[k][system] = system
            if E[k] then
                for _, w in pairs(E[k]) do
                    system.registers[k](w)
                end
            end
        end
    end

    -- Add system to unregister lists

    if system.unregisters then
        for k, v in pairs(system.unregisters) do
            if not unregisters[k] then
                unregisters[k] = {}
            end
            unregisters[k][system] = system
        end
    end
end

core.system.remove = function(system)

    for k, v in pairs(system.registers) do
        registers[k][system] = nil
    end
    for k, v in pairs(system.unregisters) do
        if E[k] then
            for _, w in pairs(E[k]) do
                system.unregisters[k](w)
            end
        end
        unregisters[k][system] = nil
    end
end
