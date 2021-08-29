local M = {}

function M.on_attach(client, bufnr)
  local keymap = require("lib.keymap")
  local on = keymap.on_press
  local lead = keymap.on_press_leader
  local opt = keymap.opt

  keymap.bind({
    on("gD", "n"):lua("vim.lsp.buf.declaration()"),
    on("gd", "n"):lua("vim.lsp.buf.definition()"),
    on("gi", "n"):lua("vim.lsp.buf.implementation()"),
    on("gr", "n"):lua("vim.lsp.buf.references()"),
    on("K", "n"):lua("vim.lsp.buf.hover()"),
    lead("k", "n"):lua("vim.lsp.buf.signature_help()"),
    lead("wa", "n"):lua("vim.lsp.buf.add_workspace_folder()"),
    lead("wr", "n"):lua("vim.lsp.buf.remove_workspace_folder()"),
    lead("D", "n"):lua("vim.lsp.buf.type_definition()"),
    lead("rn", "n"):lua("vim.lsp.buf.rename()"),
    lead("d", "n"):lua("vim.lsp.diagnostic.show_line_diagnostics({ focusable = false, border = 'rounded' })"),
    on("[d", "n"):lua("vim.lsp.diagnostic.goto_prev({ popup_opts = { focusable = false, border='rounded' } })"),
    on("]d", "n"):lua("vim.lsp.diagnostic.goto_next({ popup_opts = { focusable = false, border='rounded' } })"),
    lead("ll", "n"):lua("vim.lsp.diagnostic.set_loclist()"),

    -- Telescope lsp_xxx commands
    on("]ls"):exec("Telescope lsp_document_symbols"),
    on("[ls"):exec("Telescope lsp_workspace_symbols"),
    on("ca", "n"):exec("Telescope lsp_code_actions"),
    lead("ca", "v"):exec("Telescope lsp_range_code_actions"),
  }, { bufnr = bufnr, options = opt():noremap() })
end

return M
