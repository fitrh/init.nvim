#!/bin/sh -eu

nvim --headless -u NONE -i NONE \
	+"autocmd User PackerCompileDone quitall" \
	+"lua require('config.plugin.packer')" \
	+"PackerCompile"
