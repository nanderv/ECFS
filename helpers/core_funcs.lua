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

core.While = function(id1, id2, cfunc, func)
	core.events[id1] =  core.events[id1]  or {}
	core.events[id1][id2]  = core.events[id1][id2] or {}
	core.events[id1][id2][#core.events[id1][id2]+1] =  function()
		if cfunc() then
			func()
		end
	end
end

core.When = function(id1, id2, cfunc, func)
	core.events[id1] =  core.events[id1]  or {}
	local a = false
	core.events[id1][id2]  = core.events[id1][id2] or {}
	core.events[id1][id2][#core.events[id1][id2]+1] =  function()
		if cfunc() then
			if not a then
				func()
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
			z[#z+1]  = v
		end
		for k,v in ipairs({...}) do
			z[#z+1]  = v
		end
		return a(unpack(z))
	end
end


core.Chain = function(a, ...)
	a(unpack({...}))
	return unpack({...})
end


core.DoAll = function(...)
	local b = {...}

	return function(...)
		for k,v in ipairs(b) do
			v(unpack({...}))
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