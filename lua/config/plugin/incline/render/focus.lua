---@param name string
---@return string
local function cmp(name)
  return table.concat({ "CmpItemKind", name })
end

local hl = {
  File = "CmpItemKindFile",
  Module = "CmpItemKindModule",
  Namespace = "@namespace",
  Package = "CmpItemKindModule",
  Class = "CmpItemKindClass",
  Method = cmp("Method"),
  Property = "@property",
  Field = cmp("Field"),
  Constructor = cmp("Constructor"),
  Enum = "CmpItemKindEnum",
  Interface = "CmpItemKindInterface",
  Function = cmp("Function"),
  Variable = cmp("Variable"),
  Constant = cmp("Constant"),
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
  Operator = cmp("Operator"),
  TypeParameter = "CmpItemKindTypeParameter",
}

return function(props)
  local navic = require("nvim-navic") -- TODO: replace with `package.loaded['navic']`
  if not navic.is_available() or (navic.get_location() == "") then
    return nil
  end

  local symbols = navic.get_data()
  if #symbols < 1 then
    return nil
  end

  local separator = { " ", group = "InclineSep" }
  -- local separator_width = vim.nvim_strwidth(separator[1])
  -- local width = 0
  local result = {}
  for i, symbol in ipairs(symbols) do
    local item = { { symbol.icon, group = hl[symbol.type] } }
    -- width = width + vim.nvim_strwidth(symbol.icon) + 1

    local name = string.gsub(symbol.name, "%s", "") -- fix empty name, e.g. item[1] = { ... }
    if #name > 0 then
      local name_width = vim.api.nvim_strwidth(name) -- width = width + vim.nvim_strwidth(name_width) + 1
      if name_width > 20 then
        local head = name:sub(1, 9)
        local tail = name:sub(name_width - 10, name_width)
        name = ("%s…%s"):format(head, tail)
      end
      item[#item + 1] = { name, gui = i == #symbols and "bold" or "NONE" }
      -- item[#item + 1] = { " " }
      local line = symbol.scope.start.line
      local curline = vim.api.nvim_win_get_cursor(0)[1]
      if line ~= curline and (curline - line) > 1 then
        item[#item + 1] = { ":" .. (curline - line), group = "LineNr" }
      end
    end
    -- item[#item + 1] = { name }

    if i < #symbols then
      item[#item + 1] = separator
      -- width = width + vim.nvim_strwidth(separator_width) + 1
    end
    result[#result + 1] = item
  end
  -- result[#result].gui = "bold"

  -- local half_win_width = math.ceil(vim.api.nvim_win_get_width(props.win) / 2)
  -- while width > half_win_width do
  -- end

  if #result > 4 then
    local head = { result[1], result[2] }
    local tail = { result[#result - 1], result[#result] }
    result = { head, { "…", separator }, tail }
  end

  return {
    " ",
    result,
    " ",
  }
end
