local outline = require("symbols-outline")
local kind = require("lsp.ui.completion").kind({ icon = "default" })

outline.setup({
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = true,
  position = "right",
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  keymaps = {
    close = { "<Esc>", "q" },
    goto_location = "<CR>",
    focus_location = "o",
    hover_symbol = "<C-Space>",
    rename_symbol = "r",
    code_actions = "a",
  },
  lsp_blacklist = {},
  symbols = {
    File = { icon = kind.File, hl = "TSURI" },
    Module = { icon = kind.Module, hl = "TSNamespace" },
    Namespace = { icon = "", hl = "TSNamespace" },
    Package = { icon = "", hl = "TSNamespace" },
    Class = { icon = kind.Class, hl = "TSType" },
    Method = { icon = kind.Method, hl = "TSMethod" },
    Property = { icon = kind.Property, hl = "TSMethod" },
    Field = { icon = kind.Field, hl = "TSField" },
    Constructor = { icon = kind.Constructor, hl = "TSConstructor" },
    Enum = { icon = kind.Constructor, hl = "TSType" },
    Interface = { icon = kind.Interface, hl = "TSType" },
    Function = { icon = kind.Function, hl = "TSFunction" },
    Variable = { icon = kind.Variable, hl = "TSConstant" },
    Constant = { icon = "ﲀ", hl = "TSConstant" },
    String = { icon = "", hl = "TSString" },
    Number = { icon = "", hl = "TSNumber" },
    Boolean = { icon = "⊨", hl = "TSBoolean" },
    Array = { icon = "", hl = "TSConstant" },
    Object = { icon = "⦿", hl = "TSType" },
    Key = { icon = "", hl = "TSType" },
    Null = { icon = "ﳠ", hl = "TSType" },
    EnumMember = { icon = kind.EnumMember, hl = "TSField" },
    Struct = { icon = kind.Struct, hl = "TSType" },
    Event = { icon = kind.Event, hl = "TSType" },
    Operator = { icon = kind.Operator, hl = "TSOperator" },
    TypeParameter = { icon = kind.TypeParameter, hl = "TSParameter" },
  },
})

local set_keymap = vim.api.nvim_set_keymap
set_keymap("n", "<F8>", "<Cmd>SymbolsOutline<CR>", { noremap = false })
