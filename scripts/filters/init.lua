local a = core.filter.add
a("collision", {"collision", "position.x", "position.y", "position.rotation"})
a("dynamic_collision", {"_collision", "collision.dynamic"})
a("static_collision", {"_collision", "-_dynamic_collision"})
a("move", {"position", "mover"})
a("key_controls", {"keyboardcontrols"})
a("relative_position", {"relativeto.position"})
