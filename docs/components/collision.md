#Collision
Collision shape is tracked by the collision subcomponent.
The collision component is supposed to have the following structure:

!!!Important is to realise that the entity HAS to have a position component as well.

## type > String 
The type string is a string that is used to define which collision behavior group it's a part of. 

##polygon > {{x=x, y=y}, {x=x, y=y}, ...} 
The polygon defines the shape of the object. At least three elements.

##Optionals:

###dynamic
truth-value: Should this thing be checked for at every frame? This is used to specify which entities are actors within the game. Use this sparcely.

### moved   
Should this thing be checked for at the next frame? Will be set to false by collision system after checking
This is just a boolean. It's data is not used for anything, but it's used to specify that static objects should be updated anyway.