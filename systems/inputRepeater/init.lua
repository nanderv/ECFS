local s = {}
s.mode = ""
s.functions = {}
s.frames = 1
s.stored = {}

s.KeysPressed = {}
s.ScanPressed = {}
local KeysPressed = s.KeysPressed
local ScanPressed = s.ScanPressed
s.functions.update = function(dt)
	if s.mode == "storing" then
		local frame = {KeysPressed = {}, ScanPressed = {}}
		for k,v in pairs(s.KeysPressed) do
			frame.KeysPressed[k] = v
		end
		for k,v in pairs(ScanPressed) do
			frame.ScanPressed[k] = v
		end
		s.stored[#s.stored+1] = frame
	end
	if s.mode == "playing" then
		s.frames = s.frames + 1
		if not s.stored[s.frames] then
			s.mode = "paused"
		end
	end
	for k,v in pairs(core.events) do
		for l,w in pairs(v) do
			for m,x in ipairs(w) do
				x()
			end
		end
	end

end
function core.deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[core.deepcopy(orig_key)] = core.deepcopy(orig_value)
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
function core.startStoring()
	local a = core.deepcopy(E.A)
	s.frames = 1
	s.stored = {}
	s.mode="storing"

end

function core.stopStoring()

end

function core.startReplay()
	s.mode = "playing"
end
function core.stopReplay()

end

local kp_functions = {}
function core.add_on_key_pressed(key, func)
	kp_functions[key] = kp_functions[key]  or {}
	kp_functions[key][#kp_functions[key]+1] = func
end
core.add_on_key_pressed('f1', core.startStoring)
core.add_on_key_pressed('f2', core.startReplay)


function love.keypressed(a, b, c)
    KeysPressed[a]=b
    ScanPressed[b]=b
    if s.mode =="storing" then
    	s.stored[#s.stored].pressedEvents = s.stored[#s.stored].pressedEvents  or {}
    	s.stored[#s.stored].pressedEvents[#s.stored[#s.stored].pressedEvents+1] = nil

    end
end

function love.keyreleased(a, b)
    KeysPressed[a] = nil
    ScanPressed[b] = nil
end



core.keyboard = {}
-- This is not a function you should directly call to look for whether or not something has been pressed.
-- Instead, use the core.While or core.When to listen for events.

core.keyboard.isDown = function(a)
	return function()
		if s.mode ~= "playing" then
			return not not  KeysPressed[a]
		else
			return not not s.stored[s.frames].KeysPressed[a]
		end
	end
end

core.keyboard.isScanCodeDown = function(a)
	return function()
		if s.mode ~= "playing" then
			return not not  ScanPressed[a]
		else
			return not not s.stored[s.frames].ScanPressed[a]
		end
	end
end



core.mouseButtonDown = function(button)
	return function()
		if s.mode ~= "playing" then

		end
	end
end

local function doPrint(string)
	return function()
		print(string)
	end
end

local function printCount()
	local i = 0
	return function()
		 i = i + 1
		 print(i)
	end
end


core.events = {}


--core.While("!", "?", core.Not(core.And({core.keyboard.isDown("x"), core.keyboard.isDown("z")} )) , printCount())
--core.When("!", "A", core.keyboard.isDown("y") , printCount())
return s