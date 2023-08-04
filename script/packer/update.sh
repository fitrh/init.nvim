#!/bin/sh -eu

nvim \
	+"set cmdheight=1" \
	+"lua require('config.plugin.packer')" \
	+"PackerUpdate"
