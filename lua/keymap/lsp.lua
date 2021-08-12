local M = {}

function M.on_attach(client, nr)
  local keymap = require("util.keymap")
  local on = keymap.on_press
  local lead = keymap.on_press_leader
  local opt = keymap.opt

  keymap.bind({
    on("gD", "n", nr):lua("vim.lsp.buf.declaration()"):with(opt():noremap()),
    on("gd", "n", nr):lua("vim.lsp.buf.definition()"):with(opt():noremap()),
    on("gi", "n", nr):lua("vim.lsp.buf.implementation()"):with(opt():noremap()),
    on("gr", "n", nr):lua("vim.lsp.buf.references()"):with(opt():noremap()),
    on("K", "n", nr):lua("vim.lsp.buf.hover()"):with(opt():noremap()),
    lead("k", "n", nr):lua("vim.lsp.buf.signature_help()"):with(opt():noremap()),
    lead("ls", "n", nr):lua("vim.lsp.buf.document_symbol()"):with(opt():noremap()),
    lead("wa", "n", nr):lua("vim.lsp.buf.add_workspace_folder()"):with(opt():noremap()),
    lead("wr", "n", nr):lua("vim.lsp.buf.remove_workspace_folder()"):with(opt():noremap()),
    lead("D", "n", nr):lua("vim.lsp.buf.type_definition()"):with(opt():noremap()),
    lead("rn", "n", nr):lua("vim.lsp.buf.rename()"):with(opt():noremap()),
    lead("ca", "n", nr):lua("vim.lsp.buf.code_action()"):with(opt():noremap()),
    lead("d", "n", nr):lua("vim.lsp.diagnostic.show_line_diagnostics({ focusable = false, border = 'rounded' })"):with(opt():noremap()),
    on("[d", "n", nr):lua("vim.lsp.diagnostic.goto_prev({ popup_opts = { focusable = false, border='rounded' } })"):with(opt():noremap()),
    on("]d", "n", nr):lua("vim.lsp.diagnostic.goto_next({ popup_opts = { focusable = false, border='rounded' } })"):with(opt():noremap()),
    lead("ll", "n", nr):lua("vim.lsp.diagnostic.set_loclist()"):with(opt():noremap()),
    lead("lo", nr):exec("Telescope lsp_document_symbols"):with(opt():noremap()),
    -- TODO: add more telescope lsp command
  })
end

return M
