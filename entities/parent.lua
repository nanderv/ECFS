return function (x,y)
	local parent = {}
	parent.position = {x=x,y=y}

	parent.genome = {}
	for k,v in pairs(gene_options) do
		parent.genome[k] = {m = v[math.floor(math.floor(math.random()*#v)+1)], d =  v[math.floor(math.floor(math.random()*#v)+1)]}

	end
	return parent

end