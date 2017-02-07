local function load_component_definition(url)
    local a = resources.component_definitions
    local b = resources.component_definitions
    local last_word = ""
    local first = true
    for word in string.gmatch(url, '([^.]+)') do
        print(">"..word)
        if not first then
            b = a
            last_word = word
            if not a[word] then
                a[word] = {}
            end
            a = a[word]
        end
        first=false
    end
    b[last_word] =  my_require (url)
end


local function load_entity_definition(url)
    local a = resources.entity_definitions
    local b = resources.entity_definitions
    local last_word = ""
    local first = true
    for word in string.gmatch(url, '([^.]+)') do
        print(">"..word)
        if not first then
            b = a
            last_word = word
            if not a[word] then
                a[word] = {}
            end
            a = a[word]
        end
        first=false
    end
    b[last_word] =  my_require (url)
end


local function recursiveEnumerate(folder, fileTree, file_loader)
    local lfs = love.filesystem
    local filesTable = lfs.getDirectoryItems(folder)
    for i,v in ipairs(filesTable) do
        local file = folder.."/"..v
        if lfs.isFile(file) then
            fileTree = fileTree.."\n"..string.gsub(string.gsub(file,"/","."),".lua","")
            file_loader(string.gsub(string.gsub(file,"/","."),".lua",""))
        elseif lfs.isDirectory(file) then
            fileTree = recursiveEnumerate(file, fileTree, file_loader)
        end
    end
    return fileTree
end


return function()
        recursiveEnumerate("entities","entities", load_entity_definition)
        recursiveEnumerate("components","components", load_component_definition)
end