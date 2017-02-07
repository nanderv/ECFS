core = core or {}
core.And = function(cfuncs)
	return function()
		for k,v in ipairs(cfuncs) do
			if not v() then
				return false
			end
		end
		return true
	end
end

local loaded_paths = {}
core.my_require = function (str)
  loaded_paths[str] = str
  return require (str)
end
core.un_require = function()
    for k,v in pairs (loaded_paths) do
      package.loaded[v] = nil
	end
end
core.Or = function(cfuncs)
	return function()
		for k,v in ipairs(cfuncs) do
			if v() then
				return true
			end
		end
		return false
	end
end

core.Not = function(cfunc)
	return function()
		return not cfunc()
	end
end


function core.Rem_Events(id1, id2)
	if id2 then
		for k,v in pairs(core.events[id1][id2]) do
			core.events[id1][id2][k] = nil
		end
	else
		for l,w in pairs(core.events[id1]) do
			for k,v in pairs(core.events[w]) do
				core.events[id1][l][k] = nil
			end
		end
	end
end


core.While = function(id1, id2, cfunc, func)
	core.events[id1] =  core.events[id1]  or {}
	local me = #core.events[id1][id2]+1
	core.events[id1][id2]  = core.events[id1][id2] or {}
	core.events[id1][id2][#core.events[id1][id2] + 1] =  function(dt)
		if cfunc(dt) then
			func(dt)
		end
	end
end


core.events = {}
core.When = function(id1, id2, cfunc, func)
	core.events[id1] =  core.events[id1]  or {}
	local a = false
	core.events[id1][id2]  = core.events[id1][id2] or {}
	local me = #core.events[id1][id2]+1
	core.events[id1][id2][#core.events[id1][id2] + 1] =  function(dt)
		if cfunc(dt) then
			if not a then
				func(dt)
			end
			a = true
		else
			a = false
		end
	end

end
local fst = 1


core.PreFill = function(a, ...)
	local b = {...}
	
	return function(...)
		local z = {}
		for k,v in ipairs(b) do
			z[#z + 1]  = v
		end
		for k,v in ipairs({...}) do
			z[#z + 1]  = v
		end
		return a(unpack(z))
	end
end


core.Chain = function(a, ...)
	a(...)
	return ...
end


core.DoAll = function(...)
	local b = {...}

	return function(...)
		for k,v in ipairs(b) do
			v(...)
		end
	end
end

core.rotate_point = function(p, angle)
	
   local s = math.sin(angle)
   local c = math.cos(angle)
  
  -- rotate point
  local xnew = p.x * c - p.y * s
  local ynew = p.x * s + p.y * c

  -- translate point back:
  return {x = xnew, y = ynew}
  
end