local handler = require("lsp.handler")
local attach = require("lsp.attach")
local capabilities = require("lsp.capability")

return {
  -- root_dir
  -- cmd
  -- cmd_cwd
  -- cmd_env
  capabilities = capabilities,
  handlers = handler.default(),
  -- settings
  -- init_options
  -- name
  -- workspace_folder
  -- get_language_id
  -- on_error
  -- before_init
  -- on_init
  -- on_exit
  on_attach = attach.with.all,
  -- trace
  -- flags
}
