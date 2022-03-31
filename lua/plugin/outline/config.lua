local outline = require("symbols-outline")
local kind = require("const.LSP_KIND")

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
    File = { icon = kind.File.icon, hl = "TSURI" },
    Module = { icon = kind.Module.icon, hl = "TSNamespace" },
    Namespace = { icon = "", hl = "TSNamespace" },
    Package = { icon = "", hl = "TSNamespace" },
    Class = { icon = kind.Class.icon, hl = "TSType" },
    Method = { icon = kind.Method.icon, hl = "TSMethod" },
    Property = { icon = kind.Property.icon, hl = "TSMethod" },
    Field = { icon = kind.Field.icon, hl = "TSField" },
    Constructor = { icon = kind.Constructor.icon, hl = "TSConstructor" },
    Enum = { icon = kind.Enum.icon, hl = "TSType" },
    Interface = { icon = kind.Interface.icon, hl = "TSType" },
    Function = { icon = kind.Function.icon, hl = "TSFunction" },
    Variable = { icon = kind.Variable.icon, hl = "TSConstant" },
    Constant = { icon = "ﲀ", hl = "TSConstant" },
    String = { icon = "", hl = "TSString" },
    Number = { icon = "", hl = "TSNumber" },
    Boolean = { icon = "⊨", hl = "TSBoolean" },
    Array = { icon = "", hl = "TSConstant" },
    Object = { icon = "⦿", hl = "TSType" },
    Key = { icon = "", hl = "TSType" },
    Null = { icon = "ﳠ", hl = "TSType" },
    EnumMember = { icon = kind.EnumMember.icon, hl = "TSField" },
    Struct = { icon = kind.Struct.icon, hl = "TSType" },
    Event = { icon = kind.Event.icon, hl = "TSType" },
    Operator = { icon = kind.Operator.icon, hl = "TSOperator" },
    TypeParameter = { icon = kind.TypeParameter.icon, hl = "TSParameter" },
  },
})

local set_keymap = vim.api.nvim_set_keymap
set_keymap("n", "<F8>", "<Cmd>SymbolsOutline<CR>", { noremap = false })
