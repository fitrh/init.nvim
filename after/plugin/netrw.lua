local a = vim.api
local g = a.nvim_set_var

g("netrw_banner", 0)
-- g("netrw_list_hide", vim.call("netrw_gitignore#Hide") .. ",.*.swp")

-- TODO: Focus current file, SEE: https://github.com/k-37/hedgehog-is-diy-vim-experiment/blob/main/.vim/vimrc#L268
a.nvim_set_keymap("n", "<C-w>e", "", {
  desc = "[N]Lexplore!",
  callback = function()
    g("netrw_liststyle", 3)
    local width = vim.v.count
    if width == 0 then
      -- width = math.floor(vim.api.nvim_get_option_value("columns", {}) * 0.15)
      width = 25
    end

    vim.api.nvim_cmd({ cmd = "Lexplore", bang = true, count = width }, {})
  end,
  noremap = true,
})
