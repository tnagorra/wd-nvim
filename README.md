# wd.nvim

wd (warp directory) lets you jump to custom directories in neovim, without
using cd.

This is a neo-vim plugin that complements the ZSH plugin
[wd](https://github.com/mfaerevaag/wd)

> You can still use this plugin without installing wd. But, you will need to
create the `.warprc` file yourself. At least for now!

## Installing

with [vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'tnagorra/wd-nvim'
```

## Usage

```vim
:Wd [warp-point]
```

## Features

- [x] Jump to a warp point
- [ ] Add/Edit a warp point
- [ ] Remove a warp point
- [ ] Clean warp points

## Options

```vim
# Set location of .warprc file
let wd_warprc = '~/some/where/warp.rc'
```

## Example .warprc

```

kitab-client:~/Personal/Projects/kitab/client
kitab-server:~/Personal/Projects/kitab/server
```
