local fn, cmd, g = vim.fn, vim.cmd, vim.g

local wd = {}

function wd.get_warp_names(start)
    return vim.tbl_filter(
        function(item) return vim.startswith(item, start) end,
        vim.tbl_keys(wd.lines)
    )
end

function wd.get_current_warp_name()
    current_location = fn.getcwd()
    for key, value in pairs(wd.lines) do
        if vim.startswith(current_location, value) then
            return value
        end
    end
    return nil
end

function wd.load_warprc()
    local warp_location = g.wd_warprc or '$HOME/.warprc'
    wd.lines = {}
    for line in io.lines(fn.expand(warp_location)) do
        local i = string.find(line, ':')
        if i ~= nil then
            local key = line:sub(1, i - 1)
            local location = line:sub(i + 1)
            wd.lines[key] = fn.expand(location)
        end
    end
end

function wd.warp(key)
    if not key then
        local location = wd.get_current_warp_name()
        if location then
            print("Warped to '" .. location .. "'")
            cmd('cd ' .. location)
        else
            print("Not inside known warp point")
        end
        return
    end
    local location = wd.lines[key]
    if location ~= nil then
        print("Warped to '" .. location .. "'")
        cmd('cd ' .. location)
    else
        print("Unknown warp point '" .. key .. "'")
    end
end

_G.wd = wd;
wd.load_warprc()

return wd
