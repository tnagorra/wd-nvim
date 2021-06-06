if exists('g:loaded_wd')
    finish
endif

if !has('nvim')
    echohl Error
    echom "Sorry this plugin only works with versions of neovim that support lua"
    echohl clear
    finish
endif

lua << EOF
local wd = require('wd-nvim')
EOF

command! -nargs=0 WdRefresh lua wd.load_warps()
command! -nargs=1 -complete=customlist,v:lua.wd.warp_names Wd lua wd.warp(<f-args>)

let g:loaded_wd = 1
