-- automatically fill scripts variable with userscripts.
scripts = scripts or {}
local requirements = {}
function my_require(str)
    requirements[str] = str
    return require(str)
end

local KEEP = { "scripts.systems.collision.collision" }
function un_require()
    for k, v in pairs(requirements) do
        local keep = false
        for _, w in ipairs(KEEP) do
            if w == v then
                keep = true
            end
        end
        if not keep then
            package.loaded[v] = nil
        end
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

local rl = function()
    recursiveEnumerate("scripts", "", true)
end
RELOADALL = function()
    un_require()
print(" GAME LOGIC RESET")

    rl()

    scripts.systems.collision.collision.functions.reset()
    for k, v in pairs(E.A) do
        core.filter.update(v)
    end
end
rl()