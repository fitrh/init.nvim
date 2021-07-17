local M = {}

local maps = {
  { text = "Text", icon = { default = "", codicon = "", } },
  { text = "Method", icon = { default = "", codicon = "", } },
  { text = "Function", icon = { default = "", codicon = "", } },
  { text = "Constructor", icon = { default = "", codicon = "", } },
  { text = "Field", icon = { default = "ﴲ", codicon = "", } },
  { text = "Variable", icon = { default = "", codicon = "", } },
  { text = "Class", icon = { default = "", codicon = "", } },
  { text = "Interface", icon = { default = "ﰮ", codicon = "", } },
  { text = "Module", icon = { default = "", codicon = "", } },
  { text = "Property", icon = { default = "襁", codicon = "", } },
  { text = "Unit", icon = { default = "", codicon = "", } },
  { text = "Value", icon = { default = "", codicon = "", } },
  { text = "Enum", icon = { default = "練", codicon = "", } },
  { text = "Keyword", icon = { default = "", codicon = "", } },
  { text = "Snippet", icon = { default = "", codicon = "", } },
  { text = "Color", icon = { default = "", codicon = "", } },
  { text = "File", icon = { default = "", codicon = "" } },
  { text = "Reference", icon = { default = "", codicon = "", } },
  { text = "Folder", icon = { default = "", codicon = "", } },
  { text = "EnumMember", icon = { default = "", codicon = "", } },
  { text = "Constant", icon = { default = "ﲀ", codicon = "", } },
  { text = "Struct", icon = { default = "ﳤ", codicon = "", } },
  { text = "Event", icon = { default = "", codicon = "", } },
  { text = "Operator", icon = { default = "", codicon = "", } },
  { text = "TypeParameter", icon = { default = "", codicon = "", } },
}

M.with = function(arg)
  local opts = arg or {}
  local text = opts.text
  local icon = opts.icon or nil
  local symbols = {}

  for i = 1, #maps do
    if icon then
      symbols[i] = ("%s"):format(maps[i]["icon"][icon])
    end

    if text then
      if symbols[i] then
        symbols[i] = ("%s (%s)"):format(symbols[i], maps[i]["text"])
      else
        symbols[i] = ("(%s)"):format(maps[i]["text"])
      end
    end
    symbols[i] = (" %s "):format(symbols[i])
  end

  vim.lsp.protocol.CompletionItemKind = symbols
end

M.kind = function(arg)
  local opts = arg or {}
  local text = opts.text or nil
  local icon = opts.icon or nil
  local symbols = {}

  for i = 1, #maps do
    if icon then
      symbols[i] = ("%s"):format(maps[i]["icon"][icon])
    end

    if text then
      if symbols[i] then
        symbols[i] = ("%s (%s)"):format(symbols[i], maps[i]["text"])
      else
        symbols[i] = ("(%s)"):format(maps[i]["text"])
      end
    end
    symbols[i] = (" %s "):format(symbols[i])
  end

  return symbols
end

return M
