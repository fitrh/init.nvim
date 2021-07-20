local compe = require("compe")

compe.setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  resolve_timeout = 800,
  incomplete_delay = 400,
  max_abbr_width = 30,
  max_kind_width = 20,
  max_menu_width = 20,
  documentation = {
    max_width = 80,
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  source = {
    nvim_lsp = { kind = "  ", }, -- { priority = 1005 },
    nvim_lua = { filetype = "lua", kind = "  ", }, -- { priority = 1004, },
    luasnip = { kind = "  ", }, -- { priority = 1003 },
    buffer = { kind = "  ", }, -- { priority = 1002 },
    path = { kind = "  ", }, -- { priority = 1000 },
  },
})

local function check_back_space()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  end
  return false
end

local t = require("util.keymap").termcode
local ok, snip = pcall("luasnip")

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif ok and snip.expand_or_jumpable() then
    return t "<Plug>luasnip-expand-or-jump"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif ok and snip.jumpable(-1) then
    return t "<Plug>luasnip-jump-prev"
  else
    return t "<S-Tab>"
  end
end
