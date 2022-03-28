local M = {}

function M.attach(jdtls, bufnr)
  local keymap = require("sugar.keymap")
  local map, mode, leader = keymap.map, keymap.mode, keymap.modifier.leader
  local n, v = mode.normal, mode.vselect

  keymap.bind({
    n(map("goi", jdtls.organize_imports)),
    n(map("crv", jdtls.extract_variable)),
    n(map("crc", jdtls.extract_constant)),

    v(map(leader("rv"), function()
      jdtls.extract_variable(true)
    end)),

    v(map(leader("rc"), function()
      jdtls.extract_constant(true)
    end)),

    v(map(leader("rm"), function()
      jdtls.extract_method(true)
    end)),
  }, { buffer = bufnr })
end

return M
