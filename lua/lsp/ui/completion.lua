local M = {}

local maps = {
  { text = "Text", icon = { default = "", codicon = "" } },
  { text = "Method", icon = { default = "", codicon = "" } },
  { text = "Function", icon = { default = "", codicon = "" } },
  { text = "Constructor", icon = { default = "", codicon = "" } },
  { text = "Field", icon = { default = "ﰠ", codicon = "" } },
  { text = "Variable", icon = { default = "", codicon = "" } },
  { text = "Class", icon = { default = "", codicon = "" } },
  { text = "Interface", icon = { default = "ﰮ", codicon = "" } },
  { text = "Module", icon = { default = "", codicon = "" } },
  { text = "Property", icon = { default = "襁", codicon = "" } },
  { text = "Unit", icon = { default = "塞", codicon = "" } },
  { text = "Value", icon = { default = "", codicon = "" } },
  { text = "Enum", icon = { default = "練", codicon = "" } },
  { text = "Keyword", icon = { default = "", codicon = "" } },
  { text = "Snippet", icon = { default = "", codicon = "" } },
  { text = "Color", icon = { default = "", codicon = "" } },
  { text = "File", icon = { default = "", codicon = "" } },
  { text = "Reference", icon = { default = "", codicon = "" } },
  { text = "Folder", icon = { default = "", codicon = "" } },
  { text = "EnumMember", icon = { default = "", codicon = "" } },
  { text = "Constant", icon = { default = "", codicon = "" } },
  { text = "Struct", icon = { default = "פּ", codicon = "" } },
  { text = "Event", icon = { default = "ﯓ", codicon = "" } },
  { text = "Operator", icon = { default = "", codicon = "" } },
  { text = "TypeParameter", icon = { default = "", codicon = "" } },
}

function M.kind(args)
  local opts = args or {}
  local text = opts.text or nil
  local icon = opts.icon or nil
  local lp = opts.lp or false
  local rp = opts.rp or false

  local symbols = {}

  for i = 1, #maps do
    local kind = maps[i]["text"]
    if icon then
      symbols[kind] = ("%s"):format(maps[i]["icon"][icon])
    end

    if text then
      if symbols[kind] then
        symbols[kind] = ("%s (%s)"):format(symbols[kind], kind)
      else
        symbols[kind] = ("(%s)"):format(kind)
      end
    end

    if lp then
      symbols[kind] = (" %s"):format(symbols[kind])
    end

    if rp then
      symbols[kind] = ("%s "):format(symbols[kind])
    end
  end

  return symbols
end

return M
