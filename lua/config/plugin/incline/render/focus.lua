local hl = {
  File = "CmpItemKindFile",
  Module = "CmpItemKindModule",
  Namespace = "@namespace",
  Package = "CmpItemKindModule",
  Class = "CmpItemKindClass",
  Method = "@method",
  Property = "@property",
  Field = "@field",
  Constructor = "@constructor",
  Enum = "CmpItemKindEnum",
  Interface = "CmpItemKindInterface",
  Function = "@function",
  Variable = "@variable",
  Constant = "@constant",
  String = "@string",
  Number = "@number",
  Boolean = "@boolean",
  Array = "@type.builtin",
  Object = "@type.builtin",
  Key = "@constant.builtin",
  Null = "@constant.builtin",
  EnumMember = "CmpItemKindEnumMember",
  Struct = "CmpItemKindStruct",
  Event = "CmpItemKindEvent",
  Operator = "@operator",
  TypeParameter = "CmpItemKindTypeParameter",
}

return function()
  local navic = require("nvim-navic")
  if not navic.is_available() or (navic.get_location() == "") then
    return nil
  end

  local symbols = navic.get_data()
  if #symbols < 1 then
    return nil
  end

  local separator = { "  ", group = "InclineSep" }
  local result = {}
  for i, symbol in ipairs(symbols) do
    local item = { { symbol.icon, group = hl[symbol.type] } }

    local name = symbol.name
    local name_width = vim.api.nvim_strwidth(name)
    if name_width > 20 then
      local head = name:sub(1, 9)
      local tail = name:sub(name_width - 10, name_width)
      name = ("%s…%s"):format(head, tail)
    end
    item[#item + 1] = { name, gui = "bold" }

    if i < #symbols then
      item[#item + 1] = separator
    end
    result[#result + 1] = item
  end

  if #result > 4 then
    local head = { result[1], result[2] }
    local tail = { result[#result - 1], result[#result] }
    result = { head, { "…", separator }, tail }
  end

  return { " ", result, " " }
end
