-- A system is a combination of a register and unregister function.
-- For convenience's sake, functions can be stored within the system, but they will NOT be executed automatically!
core.system = {}
core.system.registers = {}
core.system.unregisters = {}
local registers = core.system.registers
local unregisters = core.system.unregisters
core.systems = {}
core.systems_named = {}
core.system.add = function(system)

    -- Add functionality of system to respected lists
    core.systems[system] = system
    core.systems_named[system.name] = system
    -- Add system to register lists

    if system.registers then
        -- k is the name of a filter
        for k, v in pairs(system.registers) do
            registers[k] = registers[k] or {}
            registers[k][system] = system
            if F[k] then
                for _, w in pairs(F[k]) do
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
    core.systems_named[system.name] = nil

    for k, _ in pairs(system.registers) do
        registers[k][system] = nil
    end
    for k, _ in pairs(system.unregisters) do
        if F[k] then
            for _, w in pairs(F[k]) do
                system.unregisters[k](w)
            end
        end
        unregisters[k][system] = nil
    end
end
