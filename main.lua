core = {}
require 'ECFS.filter'
require 'ECFS.entity'
require 'ECFS.system'

require 'scripts.filters'

function love.load()
	local entity1 = {position = {1,1}, engine={}}

	core.entity.add(entity1)

	print(#E.A)
	



end
function love.draw()
	
end