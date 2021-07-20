local outline = require("symbols-outline")

outline.setup({
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = true,
  position = 'right',
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  keymaps = {
    close = "<Esc>",
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    rename_symbol = "r",
    code_actions = "a",
  },
  lsp_blacklist = {},
  symbols = {
    File = { icon = "", hl = "TSURI" },
    Module = { icon = "", hl = "TSNamespace" },
    Namespace = { icon = "", hl = "TSNamespace" },
    Package = { icon = "", hl = "TSNamespace" },
    Class = { icon = "", hl = "TSType" },
    Method = { icon = "", hl = "TSMethod" },
    Property = { icon = "襁", hl = "TSMethod" },
    Field = { icon = "ﴲ", hl = "TSField" },
    Constructor = { icon = "", hl = "TSConstructor" },
    Enum = { icon = "練", hl = "TSType" },
    Interface = { icon = "ﰮ", hl = "TSType" },
    Function = { icon = "", hl = "TSFunction" },
    Variable = { icon = "", hl = "TSConstant" },
    Constant = { icon = "ﲀ", hl = "TSConstant" },
    String = { icon = "", hl = "TSString" },
    Number = { icon = "", hl = "TSNumber" },
    Boolean = { icon = "⊨", hl = "TSBoolean" },
    Array = { icon = "", hl = "TSConstant" },
    Object = { icon = "⦿", hl = "TSType" },
    Key = { icon = "", hl = "TSType" },
    Null = { icon = "ﳠ", hl = "TSType" },
    EnumMember = { icon = "", hl = "TSField" },
    Struct = { icon = "", hl = "TSType" },
    Event = { icon = "ﯓ", hl = "TSType" },
    Operator = { icon = "璉", hl = "TSOperator" },
    TypeParameter = { icon = "", hl = "TSParameter" }
  },
})

local set_keymap = vim.api.nvim_set_keymap
set_keymap("n", "<F8>", "<Cmd>SymbolsOutline<CR>", { noremap = false })
