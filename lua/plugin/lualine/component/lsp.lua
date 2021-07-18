local M = {}

function M.setup(arg)
  local opts = arg or {}
  local foreground = opts.fg or "blue"
  return {
    server = {
      function()
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then return nil end
        -- FIXME: avoid loop for get the active client (?)
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return nil
      end,
      color = { fg = foreground, gui = "BOLD" },
    },
    status = {
      function()
        if #vim.lsp.buf_get_clients() == 0 then return end
        local lsp = require("lsp-status")
        lsp.config(require("plugin.lspstatus.config"))
        lsp.register_progress()
        return lsp.status()
      end,
      color = { fg = foreground, gui = "BOLD" },
      padding = 0,
    }
  }
end

return M
