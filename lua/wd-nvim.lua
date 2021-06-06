local fn, cmd, g = vim.fn, vim.cmd, vim.g

local wd = {}

function wd.warp_names(start)
    return vim.tbl_filter(function(item) return vim.startswith(item, start) end, vim.tbl_keys(wd.lines))
end

function wd.load_warps()
    local warp_location = g.wd_warprc or '$HOME/.warprc'
    wd.lines = {}
    for line in io.lines(fn.expand(warp_location)) do
        local i = string.find(line, ':')
        if i ~= nil then
            local key = line:sub(1, i - 1)
            local location = line:sub(i + 1)
            wd.lines[key] = location
        end
    end
end

function wd.warp(key)
    local location = wd.lines[key]
    if location ~= nil then
        cmd('cd ' .. location)
        print("Warped to '" .. location .. "'")
    else
        print("Unknown warp point '" .. key .. "'")
    end
end

_G.wd = wd;
wd.load_warps()

return wd
