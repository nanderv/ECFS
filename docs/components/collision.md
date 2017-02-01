The collision component is supposed to have the following structure:
type > String 
polygon > {{x=x, y=y}, {x=x, y=y}, ...} -- At least three elements.

Optionals:
dynamic > truth-value: Should this thing be checked for at every frame?
moved   > Should this thing be checked for at the next frame? Will be set to false by collision system after checking