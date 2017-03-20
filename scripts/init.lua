scripts = scripts or {}
local collision_update = scripts.systems.collision.init.functions.update
scripts.world_update = function(dt )
	collision_update(dt)

end

function scripts.handle_input() end
function scripts.handle_pre_world_update() end
function scripts.world_update(dt) end
function scripts.handle_post_world_update() end
function scripts.handle_checkers() end
function scripts.handle_fetch_threading() end
