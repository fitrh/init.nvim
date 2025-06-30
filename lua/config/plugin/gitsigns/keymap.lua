local M = {}

function M.attach(gitsigns, bufnr)
  local keymap = require("sugar.keymap")
  local map, mode = keymap.map, keymap.mode
  local n, v = mode.normal, mode.visual

  -- TODO: migrate {next,prev}_hunk to nav_hunk
  -- TODO: Add keymap for set{loc,qf}list API
  --       gsq and gsQ?
  keymap.bind({
    n(map("]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gitsigns.next_hunk({ navigation_message = false })
      end)
      return "<Ignore>"
    end, { expr = true })),

    n(map("]C", function()
      vim.schedule(function()
        gitsigns.next_hunk({ navigation_message = false, preview = true })
      end)
      return "<Ignore>"
    end, { expr = true })),

    n(map("[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gitsigns.prev_hunk({ navigation_message = false })
      end)
      return "<Ignore>"
    end, { expr = true })),

    n(map("[C", function()
      vim.schedule(function()
        gitsigns.prev_hunk({ navigation_message = false, preview = true })
      end)
      return "<Ignore>"
    end, { expr = true })),

    n(map("gss", gitsigns.stage_hunk)),
    v(map("gss", function()
      gitsigns.stage_hunk({ vim.fn.line("v"), vim.fn.line(".") })
    end)),
    n(map("gsS", gitsigns.stage_buffer)),
    n(map("gsu", gitsigns.undo_stage_hunk)),
    n(map("gsU", gitsigns.reset_buffer)),
    n(map("gsr", gitsigns.reset_hunk)),
    v(map("gsr", function()
      gitsigns.reset_hunk({ vim.fn.line("v"), vim.fn.line(".") })
    end)),
    n(map("gsp", gitsigns.preview_hunk_inline)),
    n(map("gsP", gitsigns.preview_hunk)),
    n(map("gsb", gitsigns.blame_line)),
    n(map("gsB", function()
      gitsigns.blame_line({ full = true })
    end)),
    -- FIXME: Maybe same issue with lua/config/event.lua#L332
    n(map("gst", function()
      local a = vim.api
      local bufwin = a.nvim_win_get_buf
      local wins = a.nvim_list_wins
      if gitsigns.toggle_signs() then
        for _, win in ipairs(wins()) do
          if a.nvim_get_option_value("buflisted", { buf = bufwin(win) }) then
            a.nvim_set_option_value("signcolumn", "yes", { win = win })
          end
        end
        gitsigns.toggle_numhl(false)
      else
        for _, win in ipairs(wins()) do
          if a.nvim_get_option_value("buflisted", { buf = bufwin(win) }) then
            a.nvim_set_option_value("signcolumn", "no", { win = win })
          end
        end
      end
    end)),
    n(map("gsn", function()
      if gitsigns.toggle_numhl() then
        gitsigns.toggle_signs(false)
        local a = vim.api
        local bufwin = a.nvim_win_get_buf
        local wins = a.nvim_list_wins
        for _, win in ipairs(wins()) do
          if a.nvim_get_option_value("buflisted", { buf = bufwin(win) }) then
            a.nvim_set_option_value("signcolumn", "no", { win = win })
          end
        end
      end
    end)),
    n(map("gsl", gitsigns.toggle_current_line_blame)),
    n(map("gsL", gitsigns.toggle_linehl)),
    n(map("gsd", gitsigns.toggle_deleted)),
    n(map("gsw", gitsigns.toggle_word_diff)),
  }, { buffer = bufnr })
end

return M
