-- vi: set fdm=marker:
local a = vim.api
local o = a.nvim_get_option_value
local g = a.nvim_get_var
local fn = vim.fn

---@param buf integer buffer number
---@param winwidth integer window width
---@return string bufname buffer name with path relative to root dir
---@return boolean|nil truncated true if bufname width > window width
local function getbufname(buf, winwidth)
  -- local name = vim.api.nvim_buf_get_name(buf)
  --
  -- local relpath = vim.fs.relpath(os.getenv("PWD") or "", name)
  -- if relpath then
  --   name = relpath
  -- end
  --
  -- local home = os.getenv("HOME") or ""
  -- if name:match("^" .. home) then
  --   name = name:gsub(home, "~")
  -- end

  local name = fn.expand("%:~:.")
  local strwidth = vim.api.nvim_strwidth(name) -- TODO: Consider multibyte chars?
  if strwidth > winwidth then
    return string.sub(name, (strwidth - winwidth) + 2), true
  end

  return name, nil
end

return function()
  local buf = tonumber(g("actual_curbuf")) or 0
  local curwin = tonumber(g("actual_curwin")) or 0

  -- if a.nvim_win_get_config(curwin).relative ~= "" then -- float window
  --   return " "
  -- end

  if o("buftype", { buf = 0 }) ~= "" and not o("buflisted", { buf = 0 }) then
    return " "
  end

  if a.nvim_buf_get_name(buf) == "" and o("filetype", { buf = buf }) == "" then
    return " %f "
  end

  local winid = a.nvim_get_current_win()
  -- Unfocused window {{{
  if winid ~= curwin then -- Unfocused window
    local win_width = math.ceil(a.nvim_win_get_width(winid) * 0.8)
    local bufname, truncated = getbufname(0, win_width)
    if truncated then
      bufname = "…" .. bufname
    end
    -- return " %#StatusLineWinNr#"
    return "%#StatusLineWinNr# "
      .. a.nvim_win_get_number(winid)
      .. " %* "
      .. "%{% &pvw ? '%#StatusLine#PVW%* ' : '' %}"
      .. "%{% &mod ? '%#StatusLineModified#%* ' : '' %}"
      .. "%*"
      .. "%{% &ro ? '%#StatusLineRO#󰍁%* ' : '' %}"
      .. "%{% &mod ? '%#StatusLineFilenameMod#' : '' %}"
      .. bufname
      .. " %LL"
  end
  -- }}} end unfocused window

  local t = { " " } ---@type number[]|string[]
  local lines = a.nvim_buf_line_count(buf)
  local width = o("laststatus", {}) ~= 3 and a.nvim_win_get_width(curwin)
    or o("columns", {})

  -- left items {{{
  -- NOTE: We roll our own implementation of bufname instead because some of
  -- the inconsistencies of the %f items like it doesn't reliabelly returns the
  -- relative path or the tilde (~) sometimes get expanded
  local bufname, truncated = getbufname(buf, math.ceil(width * 0.4))
  if truncated then
    t[#t + 1] = "%#StatusLinePathSep#…%*"
  end
  local bufnames = vim.split(bufname, "/")

  -- if the first element is "", it means it start with root (/)
  -- vim.split('/a/b/c', '/') -> { '', 'a', 'b', 'c' }
  -- vim.split('a/b/c', '/') -> { 'a', 'b', 'c' }
  local len = bufnames[1] == "" and 2 or 1
  if len == 2 then
    t[#t + 1] = "%#StatusLinePathSep#/%* "
  end
  -- if width > 110 then
  -- if #bufnames - 1 > 3 then -- a/b/c/d/file.ext -> b/c/d/file.txt
  --   if not truncated then
  --     t[#t + 1] = "%#StatusLinePathSep#…%*"
  --   end
  --   t[#t + 1] = " %#StatusLinePathSep#/%* "
  --   len = #bufnames - 3 -- takes the last 3 items
  -- end

  for i = len, #bufnames - 1 do
    t[#t + 1] = "%#StatusLinePath#"
    t[#t + 1] = bufnames[i]
    t[#t + 1] = "%*"
    t[#t + 1] = " %#StatusLinePathSep#/%* "
  end
  -- end

  -- read-only and modified state
  -- TODO: Add space from truncated ellipsis if path not shown
  t[#t + 1] = "%{% &ro ? '%#StatusLineRO#󰍁%* ' : '' %}"
  t[#t + 1] = "%{% &mod ? '%#StatusLineModified#%* ' : '' %}"
  -- t[#t + 1] = "%{% &mod ? '%#StatusLineModified#•%* ' : '' %}"

  -- filename
  t[#t + 1] = "%#StatusLineFilename#"
  t[#t + 1] = "%{% &mod ? '%#StatusLineFilenameMod#' : '' %}" -- differentiate filename color if modified
  t[#t + 1] = bufnames[#bufnames]
  t[#t + 1] = "%* "

  -- diagnostic
  if width >= 90 then
    if vim.diagnostic.is_enabled({ bufnr = buf }) then
      local diagnostic = vim.diagnostic.count(buf, {})
      for i, v in ipairs({ "Error", "Warn", "Info", "Hint" }) do
        local count = diagnostic[i]
        if count then
          t[#t + 1] = "%#StatusLineDiagnostic"
          t[#t + 1] = v
          t[#t + 1] = "Sign#"
          t[#t + 1] = v:sub(1, 1)
          t[#t + 1] = "%#StatusLineDiagnostic"
          t[#t + 1] = v
          t[#t + 1] = "Count#"
          t[#t + 1] = count
          t[#t + 1] = "%*"
          t[#t + 1] = " "
        end
      end
    end
  end

  -- total line
  t[#t + 1] = "%L%#StatusLineDim#L%*"

  -- visual-mode region
  local mode = a.nvim_get_mode().mode
  if width >= 110 then
    if mode:match("^[vV\22]$") then
      -- local line, col = fn.line, fn.col
      -- local sel_line = math.abs(line("v") - line(".")) + 1
      -- local sel_col = math.abs(col("v") - col(".")) + 1
      -- TODO: fn.wordcount()

      -- if sel_line > 1 then
      --   t[#t + 1] = " "
      --   t[#t + 1] = sel_line
      --   t[#t + 1] = "%#StatusLineDim#Ln%* SELECTED"
      -- elseif sel_col > 1 then
      --   t[#t + 1] = " "
      --   t[#t + 1] = sel_line
      --   t[#t + 1] = "%#StatusLineDim#Ln%*"
      --   t[#t + 1] = " "
      --   t[#t + 1] = sel_col
      --   t[#t + 1] = "%#StatusLineDim#Col%* SELECTED"
      -- end

      -- visual-mode selected region, requires 0.11 (https://github.com/neovim/neovim/pull/27578)
      local region = fn.getregion(fn.getpos("v"), fn.getpos("."), {
        type = mode,
      })

      -- selected lines
      local sel_ln = #region
      if sel_ln > 1 then
        t[#t + 1] = " "
        t[#t + 1] = sel_ln == lines and "All" or sel_ln
        t[#t + 1] = "%#StatusLineDim#Ln%*"
      end

      -- selected characters
      -- TEST: multibyte characters
      -- 여보세요
      --  script/
      -- ├──  packer/
      -- │  ├──  compile.sh*
      -- │  ├──  install.sh*
      -- │  └──  update.sh*
      -- ├──  checkdeps*
      -- ├──  setup.sh*
      -- └──  wip*
      -- NOTE: We use `vim.fn.strcharlen` since the lua length operator (#)
      --       and nvim_strwidth API is inaccurate for multibyte characters
      local sel_char = 0
      for _, l in ipairs(region) do
        sel_char = sel_char + fn.strcharlen(l)
      end
      if sel_char > 1 then
        t[#t + 1] = " "
        t[#t + 1] = sel_char
        t[#t + 1] = "%#StatusLineDim#Char%* SELECTED"
      end
    end
  end
  t[#t + 1] = " "

  -- search results
  if a.nvim_get_vvar("hlsearch") > 0 then
    local searchcount = fn.searchcount()
    if searchcount.total and searchcount.total > 0 then
      t[#t + 1] = "Match %#StatusLineWinNr# "
      t[#t + 1] = searchcount.current
      t[#t + 1] = " %* %#StatusLineDim#of%* "
      t[#t + 1] = searchcount.total
      t[#t + 1] = " "
    end
  end

  -- t[#t + 1] = vim.lsp.status()
  -- t[#t + 1] = " "

  -- macro recording
  local recording = fn.reg_recording()
  if recording ~= "" then
    t[#t + 1] = "Recording @"
    t[#t + 1] = recording
    t[#t + 1] = " "
  end

  -- gitsigns
  local gitsigns
  if package.loaded["gitsigns"] then
    -- gitsigns = vim.api.nvim_buf_get_var(buf, "gitsigns_status_dict") or {}
    gitsigns = vim.b[buf].gitsigns_status_dict or {}
  end
  -- gitsigns hunks stat
  if width >= 90 and gitsigns then
    local changed
    if gitsigns.added and gitsigns.added > 0 then
      changed = true
      t[#t + 1] = "%#StatusLineGitDiffAddSign#+"
      t[#t + 1] = "%#StatusLineGitDiffAddCount#"
      t[#t + 1] = gitsigns.added
      t[#t + 1] = "%*"
    end
    if gitsigns.changed and gitsigns.changed > 0 then
      changed = true
      t[#t + 1] = "%#StatusLineGitDiffChangeSign#~"
      t[#t + 1] = "%#StatusLineGitDiffChangeCount#"
      t[#t + 1] = gitsigns.changed
      t[#t + 1] = "%*"
    end
    if gitsigns.removed and gitsigns.removed > 0 then
      changed = true
      t[#t + 1] = "%#StatusLineGitDiffDeleteSign#-"
      t[#t + 1] = "%#StatusLineGitDiffDeleteCount#"
      t[#t + 1] = gitsigns.removed
      t[#t + 1] = "%*"
    end
    if changed then
      t[#t + 1] = " "
    end
  end

  -- 'showcmd' with 'showcmdloc=statusline'
  if not mode:match("[vV\22]") then
    t[#t + 1] = "%S"
  end
  -- }}} end left items

  -- right items {{{
  -- gitsigns head
  t[#t + 1] = "%="
  if width >= 80 and gitsigns and gitsigns.head then
    t[#t + 1] = " %#StatusLineDim#%* "
    t[#t + 1] = "%#StatusLineGitBranch#"
    t[#t + 1] = gitsigns.head
    t[#t + 1] = "%* "
  end

  -- flutter-tools
  -- local flutter_decoration = vim.g.flutter_tools_decorations
  -- if flutter_decoration then
  --   t[#t + 1] = "%#StatusLineDim#Flutter%* "
  --   t[#t + 1] = flutter_decoration.app_version
  --   local device = flutter_decoration.device
  --   if device then
  --     t[#t + 1] = " %#StatusLineDim#Device%* "
  --     t[#t + 1] = device.name
  --     t[#t + 1] = " %#StatusLineDim#●%* "
  --     t[#t + 1] = device.platform
  --   end
  --   t[#t + 1] = " "
  -- end

  -- cursor location
  t[#t + 1] = width >= 110 and " %#StatusLineDim#Ln%* " or " "
  -- TODO: Use `line-line` format for linewise-visual mode
  -- TODO: Use `line-line, col` format for blockwise-visual mode
  -- TODO" Use `line,col - line,col` format for
  t[#t + 1] = "%"
  t[#t + 1] = #tostring(lines) -- line padding
  t[#t + 1] = "l" -- current line
  t[#t + 1] = width >= 110 and " %#StatusLineDim#Col%* " or ","
  -- NOTE: We use charcol() because the %c item shows the byte index instead of
  -- character index, which is confusing when dealing with multibyte characters
  t[#t + 1] = string.format("%-2d ", fn.charcol(".", curwin)) -- current column (character index)
  -- }}} end right items

  return table.concat(t)
end
