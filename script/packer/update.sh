#!/bin/sh -eu

set -efu

nvim \
	+"set cmdheight=1" \
	+"lua require('config.plugin.packer')" \
	+"PackerUpdate"
