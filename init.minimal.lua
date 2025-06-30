local a = vim.api

local g = a.nvim_set_var
g("mapleader", " ")
g("loaded_python3_provider", 0)
g("loaded_python_provider", 0)
g("loaded_ruby_provider", 0)
g("loaded_node_provider", 0)
g("loaded_perl_provider", 0)
g("loaded_spec", 1)
g("loaded_gzip", 1)
g("loaded_tar", 1)
g("loaded_tarPlugin", 1)
g("loaded_zip", 1)
g("loaded_zipPlugin", 1)
g("loaded_getscript", 1)
g("loaded_getscriptPlugin", 1)
g("loaded_vimball", 1)
g("loaded_vimballPlugin", 1)
g("loaded_matchit", 1)
g("loaded_matchparen", 1)
g("loaded_2html_plugin", 1)
g("loaded_logiPat", 1)
g("loaded_rrhelper", 1)
g("loaded_netrw", 1)
g("loaded_netrwPlugin", 1)
g("loaded_netrwSettings", 1)
g("loaded_netrwFileHandlers", 1)

local o = a.nvim_set_option_value
o("cmdheight", 0, {})
o("cursorline", true, {})
o("fillchars", "eob: ", {})
o("guicursor", "n-c:hor50,i-ci-ve:ver25", {})
o("laststatus", 3, {})
o("number", true, {})
o("relativenumber", true, {})
o("splitbelow", true, {})
o("splitright", true, {})
o("splitkeep", "topline", {})
o("statusline", [[ %(%m%r %)%-1.50f (%LL)%=Col %-2c Ln %3l ]], {})
o("termguicolors", true, {})
o("wrap", false, {})

local function augroup(group, autocmd)
  group = a.nvim_create_augroup(group, {})
  a.nvim_clear_autocmds({ group = group })
  autocmd(function(e, pat, cb)
    a.nvim_create_autocmd(e, {
      group = group,
      pattern = pat,
      callback = cb,
    })
  end)
end

augroup("cul_on_curr_win", function(au)
  au("WinEnter", "*", function()
    vim.wo.cursorlineopt = "both"
  end)
  au("WinLeave", "*", function()
    vim.wo.cursorlineopt = "number"
  end)
end)

augroup("highlight_on_yank", function(au)
  au("TextYankPost", "*", function()
    vim.highlight.on_yank()
  end)
end)

augroup("lunaperche_color_custom", function(au)
  au("ColorScheme", "lunaperche", function()
    local set = vim.api.nvim_set_hl
    local hi = {}

    hi.VertSplit = { bg = "NONE", ctermbg = "NONE" }

    for group, value in pairs(hi) do
      set(0, group, value)
    end
  end)
end)

augroup("retrobox_color_custom", function(au)
  au("ColorScheme", "retrobox", function()
    local set = vim.api.nvim_set_hl
    local hi = {}

    hi.CursorLineNr = { ctermfg = 214, ctermbg = 236, fg = "#fabd2f" }

    for group, value in pairs(hi) do
      set(0, group, value)
    end
  end)
end)

augroup("retrobox_color_custom", function(au)
  au("ColorScheme", "quiet", function()
    local set = vim.api.nvim_set_hl
    local hi = {}

    -- hi.CursorLineNr = { ctermfg = 214, ctermbg = 236, fg = "#fabd2f" }

    for group, value in pairs(hi) do
      set(0, group, value)
    end
  end)
end)

local colorscheme = os.getenv("NVIM_COLORSCHEME")
if colorscheme and colorscheme ~= "" then
  vim.cmd.colorscheme(colorscheme)
end
