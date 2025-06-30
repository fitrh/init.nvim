local DiagnosticKeymap = {}

function DiagnosticKeymap.attach(bufnr)
  local function opts(scope)
    return {
      buffer = bufnr,
      scope = scope,
      focusable = false,
      border = "solid",
    }
  end
  local scope = { cursor = "cursor", line = "line" }
  local api = vim.diagnostic

  local keymap = require("sugar.keymap")
  local map, leader, n = keymap.map, keymap.modifier.leader, keymap.mode.normal

  -- TODO: Open diagnostic in preview window
  local keymaps = {

    -- requires `:set mouse=nvi mousemoveevent`
    n(map("<MouseMove>", function()
      local lsp_float_win = vim.b.lsp_floating_preview
      if lsp_float_win and vim.api.nvim_win_is_valid(lsp_float_win) then
        vim.api.nvim_win_close(lsp_float_win, true)
      end

      local mousepos = vim.fn.getmousepos()
      if not mousepos or mousepos.line == 0 then
        return
      end

      local buf = vim.api.nvim_win_get_buf(mousepos.winid)
      if vim.bo[buf].buftype ~= "" then
        return
      end

      if not next(vim.diagnostic.count(buf, { lnum = mousepos.line - 1 })) then
        return
      end

      local opt = opts(scope.cursor)
      opt.relative = "mouse"
      opt.pos = { mousepos.line - 1, mousepos.column }
      api.open_float(opt)
    end)),

    n(map("]d", function()
      if api.jump then
        return api.jump({ count = 1, float = true })
      end

      api.goto_next({ float = opts(scope.cursor) }) -- 0.10 compat
    end)),

    n(map("[d", function()
      if api.jump then
        return api.jump({ count = -1, float = true })
      end

      api.goto_prev({ float = opts(scope.cursor) }) -- 0.10 compat
    end)),

    -- TODO: override `:h CTRL-W_d-default`
    -- TODO: `<C-w>d`     -> Try to open with cursor scope, then fallback to
    --                       line scope
    -- TODO: `<C-w>D`     -> vim.diagnostic.open_float({ scope = 'line' })
    -- TODO: `<C-w><C-d>` ->vim.diagnostic.open_float({ scope = 'buffer' })

    n(map(leader("ll"), api.setloclist)),
    n(map(leader("lL"), api.setqflist)),
  }

  keymap.bind(keymaps, { buffer = true })
end

return DiagnosticKeymap
