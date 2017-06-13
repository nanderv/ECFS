core = core or {}
local s = {}
core.keyboard = s
local KeysPressed = {}
local KeyWhended = {}

local ScanPressed = {}
local ScanWhended = {}
function love.keypressed(a, b, c)
    KeysPressed[a] = b
    ScanPressed[b] = b
end

function love.keyreleased(a, b)
    KeysPressed[a] = nil
    ScanPressed[b] = nil
end

s.isDown = function(str)
    return function()
        return not not KeysPressed[str]
    end
end
s.isScanDown = function(str)
    return function()
        return not not ScanPressed[str]
    end
end

s.whenDown = function(id1, id2, str, func)
    core.events[id1] = core.events[id1] or {}
    local cfunc = s.isDown(str)
    core.events[id1][id2] = core.events[id1][id2] or {}
    local me = #core.events[id1][id2] + 1
    core.events[id1][id2][#core.events[id1][id2] + 1] = function(dt)
        if cfunc(dt) then
            if not KeyWhended[str] then
                func(dt)
            end
            KeyWhended[str] = true
        else
            KeyWhended[str] = false
        end
    end
end