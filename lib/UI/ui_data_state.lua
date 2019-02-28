local data = {}

UIDATASTATE = {}

UIDATASTATE.GET = function(path)
    if #path == 0 then return data end
    local obj = data
    for i=1, #path-1 do
        obj[path[i]] = obj[path[i]] or {}
        obj = obj[path[i]]
    end

    return obj[path[#path]]
end

UIDATASTATE.PUT = function (path, new_data)
    if #path == 0 then  data  = new_data end

    local obj = data
    for i=1, #path-1 do
        obj[path[i]] = obj[path[i]] or {}
        obj = obj[path[i]]
    end
    obj[path[#path]] = new_data
end

