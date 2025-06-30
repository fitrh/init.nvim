local diagnostic = vim.diagnostic
local function trim(str)
  local s = string.gsub(str, "^%s*(.-)%s*$", "%1")

  if s:sub(-1, -1) == "." then
    s = s:sub(1, -2):gsub("^%s*(.-)%s*$", "%1")
  end

  return s
end

diagnostic.config({
  virtual_text = false,
  signs = false,
  float = {
    format = function(e)
      return trim(e.message)
    end,
    prefix = function(e, i, total)
      local prefix = total > 1 and { i, ".", " " } or {}

      if e.source then
        prefix[#prefix + 1] = trim(e.source)
        prefix[#prefix + 1] = ": "
      end

      return table.concat(prefix), "Comment"
    end,
  },
  severity_sort = true,
})

local a = vim.api
local augroup = a.nvim_create_augroup("diagnostic_on_insert", {})

a.nvim_create_autocmd("InsertEnter", {
  group = augroup,
  callback = function(args)
    local buf = args.buf
    if not diagnostic.is_disabled(buf) then
      diagnostic.hide(nil, buf)
    end
  end,
})

a.nvim_create_autocmd("InsertLeave", {
  group = augroup,
  callback = function(args)
    local buf = args.buf
    if not diagnostic.is_disabled(buf) then
      diagnostic.show(nil, buf)
    end
  end,
})
