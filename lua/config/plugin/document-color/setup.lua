require("sugar.augroup")("LspDocumentColorAttach", function(autocmd)
  autocmd("LspAttach", "*", function(args)
    if not args.data or not args.data.client_id then
      return
    end

    local ignored_clients = { dartls = true }
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if
      client.server_capabilities.colorProvider
      and not ignored_clients[client.name]
    then
      require("document-color").setup({ mode = "background" })
      require("document-color").buf_attach(args.buf)
    end
  end)
end)
