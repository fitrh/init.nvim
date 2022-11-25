local sym = require("const.LSP_KIND").Symbol
local icon_set_custom = {
  Array = sym.Array.icon,
  Boolean = sym.Boolean.icon,
  Class = sym.Class.icon,
  Constant = sym.Constant.icon,
  Constructor = sym.Constructor.icon,
  Collapsed = "",
  Enum = sym.Enum.icon,
  EnumMember = sym.EnumMember.icon,
  Event = sym.Event.icon,
  Expanded = "",
  Field = sym.Field.icon,
  File = sym.File.icon,
  Function = sym.Function.icon,
  IndentGuide = " ",
  Interface = sym.Interface.icon,
  Key = sym.Key.icon,
  Method = sym.Method.icon,
  Module = sym.Module.icon,
  Namespace = sym.Namespace.icon,
  Null = sym.Null.icon,
  Object = sym.Object.icon,
  Operator = sym.Operator.icon,
  Package = sym.Package.icon,
  Property = sym.Property.icon,
  String = sym.String.icon,
  Struct = sym.Struct.icon,
  TypeParameter = sym.TypeParameter.icon,
  Variable = sym.Variable.icon,
}

require("litee.lib").setup({
  tree = {
    icon_set_custom = icon_set_custom,
    icon_set = "nerd",
  },
  panel = {
    orientation = "right",
    panel_size = math.ceil(vim.api.nvim_get_option("columns") / 4),
  },
})

require("litee.symboltree").setup({
  icon_set_custom = icon_set_custom,
  icon_set = "nerd",
  hide_cursor = false,
  on_open = "panel",
  keymaps = { hide = "q" },
})

require("litee.calltree").setup({
  icon_set_custom = icon_set_custom,
  icon_set = "nerd",
  hide_cursor = false,
  on_open = "panel",
  keymaps = { hide = "q" },
})
