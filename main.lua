function math.clamp(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    else
        return value
    end
end

function table.find(t, val, recursive, metatables, keys, returnBool)
    if (type(t) ~= "table") then
        return nil
    end

    local checked = {}
    local _findInTable
    local _checkValue
    _checkValue = function(v)
        if (not checked[v]) then
            if (v == val) then
                return v
            end
            if (recursive and type(v) == "table") then
                local r = _findInTable(v)
                if (r ~= nil) then
                    return r
                end
            end
            if (metatables) then
                local r = _checkValue(getmetatable(v))
                if (r ~= nil) then
                    return r
                end
            end
            checked[v] = true
        end
        return nil
    end
    _findInTable = function(t)
        for k,v in pairs(t) do
            local r = _checkValue(t, v)
            if (r ~= nil) then
                return r
            end
            if (keys) then
                r = _checkValue(t, k)
                if (r ~= nil) then
                    return r
                end
            end
        end
        return nil
    end

    local r = _findInTable(t)
    if (returnBool) then
        return r ~= nil
    end
    return r
end

local mod_path = "" .. SMODS.current_mod.path 
local loaded = {}

local function load_folder(path, include_subfolders) -- STOLEN CODE 😈
	local full_path = mod_path .. path
	local files = NFS.getDirectoryItemsInfo(full_path)
	for i = 1, #files do
		local info = files[i]
		local file = path .. "/" .. info.name
		if info.type == "file" then
			if not loaded[file] then
				loaded[file] = true
				sendInfoMessage("Successfully loaded " .. file .. "!", mod_name)
				assert(SMODS.load_file(file), "Failed to load " .. file .. "!")()
			else
				sendInfoMessage("Tried to load " .. file .. " but file was already loaded!", mod_name)
			end
		elseif info.type == "directory" and include_subfolders then
			load_folder(file, true)
		end
	end
end

load_folder("content", true)