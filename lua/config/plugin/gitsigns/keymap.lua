local M = {}

function M.attach(gitsigns, bufnr)
  local keymap = require("sugar.keymap")
  local map, mode = keymap.map, keymap.mode
  local n, v = mode.normal, mode.vselect

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
    n(map("gst", gitsigns.toggle_signs)),
    n(map("gsn", gitsigns.toggle_numhl)),
    n(map("gsl", gitsigns.toggle_current_line_blame)),
    n(map("gsL", gitsigns.toggle_linehl)),
    n(map("gsd", gitsigns.toggle_deleted)),
    n(map("gsw", gitsigns.toggle_word_diff)),
  }, { buffer = bufnr })
end

return M
