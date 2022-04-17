local fn, cmd, g = vim.fn, vim.cmd, vim.g

local wd = {}

function wd.get_lines()
    if wd.lines == nil then
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
    return wd.lines
end

function wd.get_warp_names(start)
    return vim.tbl_filter(
        function(item) return vim.startswith(item, start) end,
        vim.tbl_keys(wd.get_lines())
    )
end

function wd.get_current_warp_name()
    local current_location = fn.getcwd()
    local candidates = {}
    for _, value in pairs(wd.get_lines()) do
        if vim.startswith(current_location, value) then
            table.insert(candidates, value)
            -- return value
        end
    end
    table.sort(
        candidates,
        function(foo, bar) return foo > bar end
    )
    return candidates[1]
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
    local location = wd.get_lines()[key]
    if location ~= nil then
        print("Warped to '" .. location .. "'")
        cmd('cd ' .. location)
    else
        print("Unknown warp point '" .. key .. "'")
    end
end

_G.wd = wd;

return wd
