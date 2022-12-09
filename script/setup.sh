#!/usr/bin/env sh

main() (
    [ -f ./init.lua ] && mv -v ./init.lua ./init.lua_"$(date +'%F_%H%M%S')".bak
    [ -f ./plugin/packer_compiled.lua ] && rm -rvf ./plugin/packer_compiled.lua

    cp -v ./init.lua.example ./init.lua

    DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
    PACKER_DIR="$DATA_DIR"/nvim/site/pack/packer/opt/packer.nvim
    PACKER_URL="https://github.com/wbthomason/packer.nvim.git"
    [ ! -d "$PACKER_DIR" ] && git clone --depth 1 "$PACKER_URL" "$PACKER_DIR"

    case "$1" in
        "headless")
            nvim --headless -u NONE -i NONE \
                -c 'autocmd User PackerComplete quitall' \
                -c 'lua require("config.plugin.packer")' \
                -c 'PackerSync'
            ;;
        *)
            nvim -u NONE -i NONE \
                -c 'set cmdheight=1' \
                -c 'lua require("config.plugin.packer")' \
                -c 'PackerSync'
            ;;
    esac
)

main "$@"
