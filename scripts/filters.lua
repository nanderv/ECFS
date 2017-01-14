local a = core.filter.add
a("star", 			{"isStar",	   "position"})
a("spaceship",		{"engine",	   "position"})
a("planet", 		{"position",   "-isStar", "-_spaceship"})
a("hyperspaceship", {"_spaceship", "engine.hyperdrive"})
