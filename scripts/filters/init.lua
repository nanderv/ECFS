local a = core.filter.add
a("collision", { "collision", "position.x", "position.y", "collision.width", "collision.height" })
a("moving", { "position.x", "position.y", "speed.x", "speed.y" })
a("colmov", { "_collision", "_moving"})
