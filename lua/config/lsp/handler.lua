local M = {}

function M.with(handlers)
  local _handlers = {}
  for _, handler in ipairs(handlers) do
    _handlers = vim.tbl_extend("keep", _handlers, handler)
  end
  return _handlers
end

function M.default()
  return M.with({ M.hover, M.signature_help })
end

local lsp = vim.lsp
M.signature_help = {
  ["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
    border = "solid",
    -- anchor_bias = "above", -- SEE: https://github.com/neovim/neovim/pull/24494/files
  }),
}

M.hover = {
  ["textDocument/hover"] = function(err, res, ctx, _)
    local _, winid = vim.lsp.handlers.hover(err, res, ctx, {
      border = "solid",
      silent = true, -- Disable `No information available` notification
      -- anchor_bias = "above", -- SEE: https://github.com/neovim/neovim/pull/24494/files
    })

    -- NOTE: Concealed URL is not a problem as long as the terminal emulator
    --       supports the 'URL detection' sequence
    -- NOTE: The problem with concealed URL is the terminal URL hinting won't
    --       works, so if you need to open the URL, either you need to enter the
    --       hover window or use mouse (eww)
    -- NOTE: `ftplugin/markdown` should work after https://github.com/neovim/neovim/pull/32112
    --
    -- Avoid concealed URL, SEE: https://github.com/neovim/neovim/pull/25073
    -- vim.api.nvim_set_option_value("conceallevel", 0, {
    --   scope = "local",
    --   win = winid,
    -- })
  end,
}

-- TODO: Customize `code action` handler to show server name

return M
