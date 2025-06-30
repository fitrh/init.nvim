local hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function(opts)
  opts = opts or {}
  opts.border = "solid"
  hover(opts)
end

local signature_help = vim.lsp.buf.signature_help
vim.lsp.buf.signature_help = function(config)
  config = config or {}
  config.border = "solid"
  config.close_events = { "InsertLeave" }
  signature_help(config)
end
