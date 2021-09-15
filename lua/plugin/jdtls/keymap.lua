local M = {}

function M.attach(client, bufnr)
  local keymap = require("lib.keymap")
  local on = keymap.on_press
  local lead = keymap.on_press_leader
  local opt = keymap.opt

  keymap.bind({
    on("ca", "n"):exec("JdtCodeAction"),
    lead("ca", "v"):exec("JdtCodeActionRange"),
    on("cr", "n"):exec("JdtCodeActionRefactor"),
    on("goi", "n"):exec("JdtOrganizeImports"),
    on("crv", "n"):exec("JdtExtractVariable"),
    lead("rv", "v"):exec("JdtExtractVariableRange"),
    on("crc", "n"):exec("JdtExtractConstant"),
    lead("rc", "v"):exec("JdtExtractConstantRange"),
    lead("rm", "v"):exec("JdtExtractMethod"),
  }, {
    bufnr = bufnr,
    options = opt():noremap(),
  })
end

return M
