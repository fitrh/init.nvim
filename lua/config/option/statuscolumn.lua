local a, fn = vim.api, vim.fn
local v = a.nvim_get_vvar
local o = a.nvim_get_option_value

return function()
  local t = {}

  local fold
  if o("foldcolumn", { win = 0 }) ~= "0" then
    fold = "%C"
    t[#t + 1] = fold
    t[#t + 1] = " "
  end

  local virtnum = v("virtnum")
  if virtnum >= 0 then -- Not a virtual line
    local rnu = o("relativenumber", { win = 0 })
    if rnu or o("number", { win = 0 }) then
      if not fold then
        t[#t + 1] = " "
      end
      t[#t + 1] = "%="

      local lnum, selected = v("lnum")
      local vmode = a.nvim_get_mode().mode:match("[vV\22]")
      if vmode then -- highlight linenr for visual-selected region
        local region = fn.getregionpos(fn.getpos("v"), fn.getpos("."))
        selected = (lnum >= region[1][1][2] and lnum <= region[#region][1][2])
        if selected then
          t[#t + 1] = "%#CursorLineNr#"
          -- NOTE: Previously, `hi CursorLineNr gui=bold` use Normal as its fallback,
          -- after https://github.com/neovim/neovim/pull/29976 it uses its own
          -- highlight group. To get the previous behavior, we need to define
          -- fg for CursorLineNr
        end
      end

      if virtnum > 0 then -- wrapped line
        local endwrap = a.nvim_win_text_height(0, {
          start_row = lnum - 1,
          end_row = lnum - 1,
        }).all - 1
        t[#t + 1] = virtnum == endwrap and "└" or "│"
      else
        -- TODO: Add `H`,`L`, and `M` indicator
        local relnum = v("relnum")
        t[#t + 1] = (relnum > 0 and rnu and not selected) and relnum or lnum
      end

      t[#t + 1] = " "
      -- t[#t + 1] = " %#LineNr#|%* "
    end
  end

  if o("signcolumn", { win = 0 }) ~= "no" then
    t[#t + 1] = "%s"
  end

  if #t == 0 then
    return " "
  end
  return table.concat(t)
end
