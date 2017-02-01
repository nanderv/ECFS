core.filter.add("FilterNAME", {#PARAMS#})
=====================
Params can be of the following structure:
#"componentname"
 Only add entities with this component
#"_filtername"
Only add entities that ALREADY have this filter attached. Filter rules are applied in order.
#"-componentname"
Entity CANNOT have this Component
#"-_filtername"
Entity CANNOT ALREADY have this filter attached.