-- SEE: https://github.com/saccarosium/netrw.vim/pull/87
-- NOTE: Use vertical box drawing character for tree-listing
--         * go to VIMRUNTIME/autoload/netrw.vim
--         * find `let s:treedepthstring = ...`
--         * add `if (has("gui_running") || has("nvim")) && ...`

local a = vim.api
local set = a.nvim_set_option_value
local win = { scope = "local", win = 0 }

a.nvim_create_autocmd("WinClosed", {
  group = a.nvim_create_augroup("aftre/ftplugin/netrw.lua", {}),
  buffer = 0,
  callback = function(args)
    if vim.bo[args.buf].filetype ~= "netrw" then
      return
    end

    a.nvim_set_var("netrw_liststyle", nil)
  end,
})

set("number", true, win)
set("relativenumber", true, win)
set("statuscolumn", " %=%(%{v:relnum ? v:relnum : v:lnum} %)", win)

a.nvim_buf_set_keymap(0, "n", "Q", "<Cmd>quit<CR>", { noremap = true })
-- TODO: https://github.com/k-37/hedgehog-is-diy-vim-experiment/blob/main/.vim/vimrc#L273
a.nvim_buf_set_keymap(0, "n", "h", "-", {})
a.nvim_buf_set_keymap(0, "n", "l", "<CR>", {})
