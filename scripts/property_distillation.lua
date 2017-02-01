
distill = {}
distill.l = {}


distill.numerical_probability = function(name)
  return function(beast)
    local m = beast.genome.polygons.m
    local d = beast.genome.polygons.d
    local mc = gene_dominance.polygons[m]
    local dc = gene_dominance.polygons[d]
    local mr = mc / (mc + dc)

    if mr > math.random() then
      beast.polygons = m
    else
      beast.polygons = d
    end
  end
end


distill.binary_dominance = function(name)
  return function(beast)
    local m = beast.genome[name].m
    local d = beast.genome[name].d
    if m and d then
      beast[name] =  true
    end  
  end
end


distill.add = function(f)
  distill.l[#distill.l+1] = f
end
require 'scripts.distill_rules.polygon'


function distill.run(beast)
  for k,v in ipairs(distill.l) do
    v(beast)
  end
  beast.born = true
end