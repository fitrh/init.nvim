local hl = {
  File = "CmpItemKindFile",
  Module = "CmpItemKindModule",
  Namespace = "TSNamespace",
  Package = "CmpItemKindModule",
  Class = "CmpItemKindClass",
  Method = "TSMethod",
  Property = "TSProperty",
  Field = "TSField",
  Constructor = "TSConstructor",
  Enum = "CmpItemKindEnum",
  Interface = "CmpItemKindInterface",
  Function = "TSFunction",
  Variable = "TSVariable",
  Constant = "TSConstant",
  String = "TSString",
  Number = "TSNumber",
  Boolean = "TSBoolean",
  Array = "TSTypeBuiltin",
  Object = "TSTypeBuiltin",
  Key = "TSConstBuiltin",
  Null = "TSConstBuiltin",
  EnumMember = "CmpItemKindEnumMember",
  Struct = "CmpItemKindStruct",
  Event = "CmpItemKindEvent",
  Operator = "TSOperator",
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
