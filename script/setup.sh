#!/usr/bin/env sh

main() (
    [ -f "./init.lua" ] &&
        mv "./init.lua" "./init.lua_$(date +'%F_%H%M%S').bak"
    cp "./init.lua.example" "./init.lua"

    [ -f "./plugin/packer_compiled.lua" ] &&
        rm -rvf "./plugin/packer_compiled.lua"

    PACKER="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/packer/opt/packer.nvim
    [ ! -d "$PACKER" ] &&
        git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER"

    case "$1" in
        "headless")
            nvim --headless \
                -u NONE \
                -c 'autocmd User PackerComplete quitall' \
                -c 'lua require("config.plugin.packer")' \
                -c 'PackerSync'
            ;;
        *)
            nvim \
                -u NONE \
                -c 'set cmdheight=1' \
                -c 'lua require("config.plugin.packer")' \
                -c 'PackerSync'
            ;;
    esac
)

main "$@"
