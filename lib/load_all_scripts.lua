-- automatically fill scripts variable with userscripts.
scripts = scripts or {}
local requirements = {}
function my_require(str)
    requirements[str] = str
    return require(str)
end

function un_require()
    for k, v in pairs(requirements) do
        package.loaded[v] = nil
    end
end

local function load_script(url)
    local a = scripts
    local b = scripts
    local last_word = ""
    local first = true
    for word in string.gmatch(url, '([^.]+)') do
        if not first then
            b = a
            last_word = word
            if not a[word] then
                a[word] = {}
            end
            a = a[word]
        end
        first = false
    end

    b[last_word] = my_require(url)
end

local function recursiveEnumerate(folder, fileTree, first)

    local lfs = love.filesystem
    local filesTable = lfs.getDirectoryItems(folder)
    for i, v in ipairs(filesTable) do
        local file = folder .. "/" .. v
        if lfs.isFile(file) and not first then
            fileTree = fileTree .. "\n" .. string.gsub(string.gsub(file, "/", "."), ".lua", "")
            load_script(string.gsub(string.gsub(file, "/", "."), ".lua", ""))
        elseif lfs.isDirectory(file) then
            fileTree = recursiveEnumerate(file, fileTree, false)
        end
    end
    return fileTree
end

recursiveEnumerate("scripts", "", true)
pprint(scripts)