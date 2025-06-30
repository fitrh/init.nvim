vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("attach_lsp_document_color", {}),
  callback = function(args)
    if not args.data or not args.data.client_id then
      return
    end

    local client = vim.lsp.get_clients({
      id = args.data.client_id,
      bufnr = args.buf,
      name = "tailwindcss",
    })[1]

    if client and client.server_capabilities.colorProvider then
      local plugin = require("tailwindcss-colors")
      plugin.setup()
      plugin.buf_attach(args.buf)
    end
  end,
})
