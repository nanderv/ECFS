Core Logic
==========

Core logic describes certain higher-order functions that will be useful when designing games. This section explains them, and explains (for some of them) usecases.

Most of these things are intended to pack functions into other functions that will execute the functions given as parameters upon usage.

core.And = function(cfuncs)
-------------------------
core.And is a function that gets functions (without arguments) and executes them all, checking that they all return a positive result. If so, it returns true, if it doesn't it returns false.

This can be used to see if the player holds both the spacebar and the z-key at the same time, or if the player jumps while standing on the ground.

core.Or = function(cfuncs)
--------------------------
core.Or is a function that gets functions (without arguments) and executes  them all, checking that ANY of them returns a positive result. If so, it returns true, if it doesn't, it returns false.


core.Not = function(cfunc)
--------------------------
core.Not negates the result of a function.

core.While = function(id1, id2, cfunc, func)
--------------------------------------------
core.While is a function that, for each frame, executes func if cfunc results true (for that frame).

This could be used to say: when the key "w" is down, move up.

core.When = function(id1, id2, cfunc, func)
--------------------------------------------
core.When is a function that, for each frame, executes func if cfunc results true (for that frame).

This could be used to say: shoot if left mouse button is clicked.

core.PreFill = function(a, ...)
-----------------------------
core.PreFill enables you to prespecify a few of the arguments of a function. Example:
```
local function add (x,y)
	return x + y
end

local function add1 = core.PreFill(add, 1)
print(add1(2)) -- prints the number 3
```

core.Chain = function(a, ...)
-----------------------------
core.Chain is a function that receives a function and arguments, and executes the function using those arguments. It then returns the given arguments. This is used for magical chaining.

core.DoAll = function(...)
--------------------------
core.DoAll is a function that receives multiple functions and wraps them into a new function. Executing this new function means that they all get executed with the same arguments. This allows for some nice chaining.