core = core or {}
local s = {}
core.keyboard = s
local KeysPressed = {}
local ScanPressed = {}
function love.keypressed(a, b, c)
    KeysPressed[a]=b
    ScanPressed[b]=b
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

