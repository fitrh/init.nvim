# init.nvim

What's under my `$XDG_CONFIG_HOME/nvim`

## Requirements

1. **Neovim 0.11** or later (nightly build is preferred)
2. `make` or `cmake`
3. packer.nvim [requirements](https://github.com/wbthomason/packer.nvim#requirements)
4. nvim-treesitter [requirements](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
   1. `tar`
   2. `curl`
   3. `git`
   4. A C compiler and libstdc++

## Set up

Run the [setup.sh](./script/setup.sh) script

```sh
./script/setup.sh # or ./script/setup.sh headless
```

## Managing plugin with packer.nvim

### Install

1. Add plugin specification into `plugins` table in [`lua/config/plugin/packer.lua`](./lua/config/plugin/packer.lua)
2. Run [`./script/packer/install.sh`](./script/packer/install.sh)

For more complex plugin specification:

1. Create a directory under [`lua/config/plugin/`](./lua/config/plugin/) consisting of the following files

   - **`packerspec.lua`**, plugin specification
   - `setup.lua` (optional), load the plugin main module and pass the config
   - `keymap.lua` (optional), custom keymaps
   - `command.lua` (optional), custom user commands

2. Use `packerspec.lua` to load optional and other files, probably in the `config`
   key, with `setup.lua` loaded first. If the plugin provides some sort of hook
   mechanism like LSP `on_attach`, use it instead.

3. Load `packerspec.lua` into `plugins` table in [`lua/config/plugin/packer.lua`](./lua/config/plugin/packer.lua)
4. Run [`./script/packer/install.sh`](./script/packer/install.sh)

### Update

Run [`./script/packer/update.sh`](./script/packer/update.sh)

### Compile

Run [`./script/packer/compile.sh`](./script/packer/compile.sh) for any changes to the `packerspec.lua` files

---

## TODO

- [ ] A nice README

If you have any questions or problems with this configuration, feel free to
open a [discussion][1].

[1]: https://github.com/fitrh/init.nvim/discussions/new
