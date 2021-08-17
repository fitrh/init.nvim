local M = {}

function M.on_attach(client, bufnr)
  local keymap = require("util.keymap")
  local on = keymap.on_press
  local lead = keymap.on_press_leader
  local opt = keymap.opt

  keymap.bind({
    on("gD", "n"):lua("vim.lsp.buf.declaration()"):with(opt():noremap()),
    on("gd", "n"):lua("vim.lsp.buf.definition()"):with(opt():noremap()),
    on("gi", "n"):lua("vim.lsp.buf.implementation()"):with(opt():noremap()),
    on("gr", "n"):lua("vim.lsp.buf.references()"):with(opt():noremap()),
    on("K", "n"):lua("vim.lsp.buf.hover()"):with(opt():noremap()),
    lead("k", "n"):lua("vim.lsp.buf.signature_help()"):with(opt():noremap()),
    lead("wa", "n"):lua("vim.lsp.buf.add_workspace_folder()"):with(opt():noremap()),
    lead("wr", "n"):lua("vim.lsp.buf.remove_workspace_folder()"):with(opt():noremap()),
    lead("D", "n"):lua("vim.lsp.buf.type_definition()"):with(opt():noremap()),
    lead("rn", "n"):lua("vim.lsp.buf.rename()"):with(opt():noremap()),
    lead("d", "n"):lua("vim.lsp.diagnostic.show_line_diagnostics({ focusable = false, border = 'rounded' })"):with(opt():noremap()),
    on("[d", "n"):lua("vim.lsp.diagnostic.goto_prev({ popup_opts = { focusable = false, border='rounded' } })"):with(opt():noremap()),
    on("]d", "n"):lua("vim.lsp.diagnostic.goto_next({ popup_opts = { focusable = false, border='rounded' } })"):with(opt():noremap()),
    lead("ll", "n"):lua("vim.lsp.diagnostic.set_loclist()"):with(opt():noremap()),

    -- Telescope lsp_xxx commands
    on("]ls"):exec("Telescope lsp_document_symbols"):with(opt():noremap()),
    on("[ls"):exec("Telescope lsp_workspace_symbols"):with(opt():noremap()),
    on("ca", "n"):exec("Telescope lsp_code_actions"):with(opt():noremap()),
    lead("ca", "v"):exec("Telescope lsp_range_code_actions"):with(opt():noremap()),
  }, bufnr)
end

return M
