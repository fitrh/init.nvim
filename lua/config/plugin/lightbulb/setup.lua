local function attach(bufnr)
  require("nvim-lightbulb").setup({
    validate_config = "never",
    sign = { enabled = false },
    virtual_text = {
      enabled = true,
      text = "  ",
      hl_mode = "combine",
    },
    float = { enabled = false },
  })

  local api = vim.api
  local au = api.nvim_create_autocmd
  local group = api.nvim_create_augroup("lightbulb_update", { clear = false })
  au({ "CursorHold", "InsertLeave" }, {
    group = group,
    buffer = bufnr,
    callback = function()
      require("nvim-lightbulb").update_lightbulb()
    end,
  })
  au({ "CursorMoved", "InsertEnter" }, {
    group = group,
    buffer = bufnr,
    callback = function(args)
      require("nvim-lightbulb").clear_lightbulb(args.buf)
    end,
  })
end

local api = vim.api
api.nvim_create_autocmd("LspAttach", {
  group = api.nvim_create_augroup("lightbulb_attach", {}),
  callback = function(args)
    local data = args.data
    if not data or not data.client_id then
      return
    end

    local client = vim.lsp.get_client_by_id(data.client_id)
    if client.supports_method("textDocument/codeAction") then
      vim.api.nvim_set_hl(0, "LightBulbVirtualText", {
        link = "DiagnosticWarn",
      })
      -- attach(args.buf)
    end
  end,
})
