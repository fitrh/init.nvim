local default = vim.ui.select

vim.ui.select = function(items, opts, on_choice)
  if opts.kind ~= "codeaction" then
    return default(items, opts, on_choice)
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local lines = {}
  for i, e in ipairs(items) do
    lines[#lines + 1] = i .. " " .. opts.format_item(e)
    vim.api.nvim_buf_set_keymap(buf, "n", tostring(i), "", {
      callback = function()
        on_choice(items[i])
        vim.api.nvim_win_close(0, true)
      end,
      noremap = true,
      silent = true,
    })
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "cursor",
    row = 0,
    col = 0,
    width = math.ceil(0.3 * vim.o.columns),
    height = math.min(#lines, math.ceil(0.5 * vim.o.lines)),
    style = "minimal",
    border = "solid",
    title = { { opts.prompt or "Select:", "NormalFloat" } },
  })
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].buftype = "nofile"
  vim.wo[win].cursorline = true

  local map = vim.api.nvim_buf_set_keymap
  map(buf, "n", "<C-n>", "<Nop>", {})
  map(buf, "n", "<C-p>", "<Nop>", {})
  map(buf, "n", "<CR>", "", {
    callback = function()
      local sel = vim.api.nvim_win_get_cursor(win)[1]
      on_choice(items[sel])
      vim.api.nvim_win_close(win, true)
    end,
    silent = true,
    noremap = true,
  })

  map(buf, "n", "q", "", {
    callback = function()
      vim.api.nvim_win_close(win, true)
    end,
    silent = true,
    noremap = true,
  })
end
