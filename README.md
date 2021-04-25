# Zessions

**WARNING** : This plugin doesn't have cool features !

Zessions is just a plugin for Neovim that let the user manage its session files without having to type full paths, that's all ! (for now !)

<br>![zessions.png](./screenshots/zessions.png)<br>

## Requirement

Zessions was developed for [Neovim](https://github.com/neovim/neovim) [Nightly (>=0.5)](https://github.com/neovim/neovim/releases).

Even if Zessions is a plugin on its own, the experience will be a lot better with the awesome [Telescope](https://github.com/nvim-telescope/telescope.nvim) plugin,
so a Telescope extension is included !

## Installation

[vim-plug](https://github.com/junegunn/vim-plug)

```vimscript
Plug 'Ind1eMonk3y/zessions'
```

[packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use 'Ind1eMonk3y/zessions'
```

[Paq](https://github.com/savq/paq-nvim)

```lua
paq "Ind1eMonk3y/zessions"
```

## Configuration

### Plugin configuration

Default configuration :

```lua
require("zessions").config:update({
  cwd = vim.fn.stdpath("data").."/sessions",
  force_overwrite = false,
  force_delete = false,
  bdelete = false,
  verbose = true,
})
```

- `cwd` : Directory where the sessions files are stored. This directory must exists, it won't be created !
- `force_overwrite` : If set to `true`, an existing session file will be overwritten without asking the user for confirmation.
- `force_delete` : If set to `true`, an existing session file will be deleted without asking the user for confirmation.
- `bdelete` : If set to `true`, existing buffers that are not modified will be deleted before restoring a session.
- `verbose` : If set to `false`, messages about saved, deleted or restored sessions won't be printed under the statusline.

### Telescope extension configuration

The extension configuration can be set via Telescope setup function.

Under the hood, the extension use `telescope.find_files`.

```lua
require('telescope').setup{
  extensions = {
    zessions = {
      cwd = vim.fn.stdpath("data").."/sessions",
      width = 55,
    },
  }
}
require('telescope').load_extension('zessions')
```

The extension configuration can also be set via the extension main function.

```lua
require('telescope').extensions.zessions.sessions({
  cwd = vim.fn.stdpath("data").."/sessions/vim_nvim",
  width = 55,
})
```

For convenience, the plugin configuration can also be set by passing a second table.

```lua
require('telescope').extensions.zessions.sessions({
    cwd = vim.fn.stdpath("data").."/sessions/vim_nvim",
    width = 55,
  },
  {
    cwd = vim.fn.stdpath("data").."/sessions",
    force_overwrite = false,
    force_delete = false,
    bdelete = false,
    verbose = true,
})
```

## Mappings

The plugin doen't use or provide any mappings.

The extension has default mappings to help manage the sessions files.

All mappings are set for the insert mode in the dropdown prompt.

- `<C-a>` : Add or overwrite the session file by using the prompt input as file name.
- `<C-s>` : Save or overwrite the session file by using the selected entry as file name.
- `<C-d>` : Delete the session file by using the selected entry as file name.
- `<C-e>` : Complete prompt input by using the selected entry as file name.
- `<CR>` : Restore the session by using the selected entry.

## Project status

This project is in early stage but definitely usable !

