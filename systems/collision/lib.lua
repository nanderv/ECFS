-- Contains helper functions for the collision system.
local f = {}
-- elements of list: {{x=x, y=y, minx=x, miny=y, maxx=x, maxy=y, }}

-- Get a circle around an entity. Stays valid when polygon rotates around origin (trivially true)
f.circle_around = function(entity, list)
	local poly = entity.collision.polygon
	local x,y = entity.position.x, entity.position.y
	local radius = 0

	for k,v in ipairs(poly) do
		local xz = v.x
		local yz = v.y
		radius = math.max(radius, xz*xz + yz*yz)
	end
	list[entity] = math.sqrt(radius)
	return x, y, math.sqrt(radius)
end

-- assume: has at least one point. Important: does NOT auto-update when polygon rotates.
f.aabb_around = function(entity, list)
	local poly = {}
	for k,v in ipairs(entity.collision.polygon) do
		poly[#poly+1] =core.rotate_point(v, entity.position.rotation)
	end
	local x,y = entity.position.x, entity.position.y
	local maxx = poly[1].x
	local minx = poly[1].x
	local maxy = poly[1].y
	local miny = poly[1].y
	for k,v in ipairs(poly) do
		maxx = math.max(maxx, v.x)
		minx = math.min(minx, v.x)
		maxy = math.max(maxy, v.y)
		miny = math.min(miny, v.y)
	end
	list[entity] = {minx = minx, miny = miny, maxx = maxx, maxy = maxy}
	return x,y,minx, miny, maxx, maxy
end


local rules = {}
f.add_rule = function(type1, type2, func)
	rules[type1] = rules[type1] or {}
	rules[type1][type2] = func
end
f.clear_rules = function()
	rules = {}
end
f.rem_rule = function(type1, type2)
	if rules[type1] then
		rules[type1][type2] = nil
	end
end

f.check_rule = function(entity1, entity2)
	if rules[entity1.collision.type] and rules[entity1.collision.type][entity2.collision.type] then
		 return not not rules[entity1.collision.type][entity2.collision.type]
	end
end

f.execute_if_rule = function(entity1, entity2, prev)
	return rules[entity1.collision.type][entity2.collision.type](entity1, entity2, prev)
end

local function point_in_polygon(polygon, point, position, position2)
  local odd = false
  local prev = #polygon

  local y = point.y+position2.y-position.y
  local x = point.x+position2.x-position.x
  for k,v in ipairs(polygon) do
  	local w = polygon[prev]
  	if (v.y < y and w.y >= y) or (w.y < y and v.y >= y) then
  		if (v.x + (y - v.x) / (w.x-v.x)*(w.x-v.x) < x) then
  			odd = not odd
  		end
  	end
  	prev = k
  end
  return odd
end


function segmentIntersects(x1, y1, x2, y2, x3, y3, x4, y4)
   local d = (y4-y3)*(x2-x1)-(x4-x3)*(y2-y1)
   local Ua_n = ((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3))
   local Ub_n = ((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3))
   if d == 0 then

       return false
   end
   local Ua = Ua_n / d
   local Ub = Ub_n / d
   if Ua >= 0 and Ua <= 1 and Ub >= 0 and Ub <= 1 then
       return true
   end
   return false
end


local function line_in_polygon(polygon, start, finish, position, position2)
	local old = polygon[#polygon]

	for k,v in ipairs( polygon) do
		if segmentIntersects(	v.x+position.x,v.y+position.y,
								old.x+position.x,old.y+position.y,
								start.x+position2.x,start.y+position2.y,
								finish.x+position2.x,finish.y+position2.y) then
			return true
		end
		old = v
	end
	return false
end


f.polygon_in_polygon = function(polygon2, polygon,position2,position)
	local hit = false
	
	local old = polygon2[#polygon2]
	for k,v in ipairs( polygon2) do
		if point_in_polygon(polygon,v,position, position2) then
			hit = true
			break
		end
		if line_in_polygon(polygon, old, v,position,position2) then
			hit = true
			break
		end
		old = v
	end
	for k,v in ipairs( polygon) do
		if point_in_polygon(polygon2,v,position2, position) then
			hit = true
		end
	end
	return hit

end


f.rotate_poly = function(entity)
	local poly = {}
	for k,v in ipairs(entity.collision.polygon) do
		poly[#poly+1] = core.rotate_point(v, entity.position.rotation)
	end
	return poly
end

f.trivial_solve = function (entity1, entity2, prev)
	entity1.position = prev
end

return f