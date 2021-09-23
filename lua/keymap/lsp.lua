local M = {}

function M.attach(client, bufnr)
  local keymap = require("lib.keymap")
  local on = keymap.on_press
  local lead = keymap.on_press_leader
  local opt = keymap.opt
  local maps = {}

  if client.resolved_capabilities.document_formatting then
    maps["Format"] = lead("<CR>", "n"):exec("LspFormatSync<CR><BAR>:w")
  end

  maps["wa"] = lead("wa", "n"):lua("vim.lsp.buf.add_workspace_folder()")
  maps["wr"] = lead("wr", "n"):lua("vim.lsp.buf.remove_workspace_folder()")
  maps["nr"] = lead("rn", "n"):lua("vim.lsp.buf.rename()")
  maps["gc"] = on("gc", "n"):lua("vim.lsp.codelens.run()")

  local capabilityKeys = {
    { key = ";ls", mode = "n", cmd = "SignatureHelp" },
    { key = "K", mode = "n", cmd = "Hover" },
    { key = ";lD", mode = "n", cmd = "GoToDeclaration" },
    { key = ";ld", mode = "n", cmd = "GoToDefinition" },
    { key = ";lt", mode = "n", cmd = "GoToTypeDefinition" },
    { key = ";li", mode = "n", cmd = "ListImplementation" },
    { key = ";lr", mode = "n", cmd = "ListReference" },
    { key = ";lr", mode = "n", cmd = "ListReference" },
    { key = ";lr", mode = "n", cmd = "ListReference" },
  }
  local diagnosticKeys = {
    { key = "<Leader>d", mode = "n", cmd = "ShowInline" },
    { key = "[d", mode = "n", cmd = "GoToPrev" },
    { key = "]d", mode = "n", cmd = "GoToNext" },
    { key = "<Leader>ll", mode = "n", cmd = "LocList" },
  }
  local telescopeKeys = {
    { key = "]ls", mode = "n", cmd = "lsp_document_symbols" },
    { key = "[ls", mode = "n", cmd = "lsp_workspace_symbols" },
    { key = "ca", mode = "n", cmd = "lsp_code_actions" },
    { key = "ca", mode = "v", cmd = "lsp_range_code_actions" },
  }

  for _, v in ipairs(capabilityKeys) do
    if vim.fn.exists((":Lsp%s"):format(v.cmd)) then
      maps[v.cmd] = on(v.key, v.mode):exec(("%s%s"):format("Lsp", v.cmd))
    end
  end

  for _, v in ipairs(diagnosticKeys) do
    maps[v.cmd] = on(v.key, v.mode):exec(("%s%s"):format("Diagnostic", v.cmd))
  end

  for _, v in ipairs(telescopeKeys) do
    maps[v.cmd] = on(v.key, v.mode):exec(("%s %s"):format("Telescope", v.cmd))
  end

  keymap.bind(maps, { bufnr = bufnr, options = opt():noremap() })
end

return M
