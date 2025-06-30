local M = {}

M.on_click = {
  focus_buf = function(buf, click, mouse, mod)
    vim.api.nvim_win_set_buf(0, buf)
  end,
}

function M.eval()
  return table.concat(vim
    .iter(vim.api.nvim_list_bufs())
    :filter(function(b)
      return vim.bo[b].buflisted
    end)
    :map(function(b)
      local start = "%" .. b .. "T"
      local click = "%" .. b .. "@v:lua.require'tabline'.on_click.focus_buf@"

      return start
        .. click
        .. "%#TabLine"
        .. (b == vim.api.nvim_get_current_buf() and "Sel" or "")
        .. "# "
        -- .. (vim.bo[b].readonly and "[RO] " or "     ")
        .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(b), ":.")
        -- .. (vim.bo[b].modified and " [+]" or "    ")
        .. " %*%X"
    end)
    :totable())
end

return M
