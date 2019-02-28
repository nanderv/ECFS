--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 27/02/2019
-- Time: 09:39
-- To change this template use File | Settings | File Templates.
--

local events = {}

local i = 1
local eventsList = {{}, {}}
events.add = function(event)
    local myList = eventsList[i]
    myList[#myList+1] = event

end

events.loop = function(dt)
    for k,v in ipairs(eventsList[i]) do
        if v.object == nil or F[v.object] then
            v.func(v.data)
        end
    end

    -- reset
    i = i % 2 + 1
    eventsList[i] = {}
end

return events
