local command = require("lib.command")

local M = {}

function M.attach(client, bufnr)
  command.create({
    name = "JdtCodeAction",
    option = "-buffer",
    cmd = [[lua require("jdtls").code_action()]]
  })
  command.create({
    name = "JdtCodeActionRange",
    option = "-buffer",
    cmd = [[lua require("jdtls").code_action(true)]]
  })
  command.create({
    name = "JdtCodeActionRefactor",
    option = "-buffer",
    cmd = [[lua require("jdtls").code_action(false, "refactor")]]
  })
  command.create({
    name = "JdtOrganizeImports",
    option = "-buffer",
    cmd = [[lua require("jdtls").organize_imports()]]
  })
  command.create({
    name = "JdtExtractVariable",
    option = "-buffer",
    cmd = [[lua require("jdtls").extract_variable()]]
  })
  command.create({
    name = "JdtExtractVariableRange",
    option = "-buffer",
    cmd = [[lua require("jdtls").extract_variable(true)]]
  })
  command.create({
    name = "JdtExtractConstant",
    option = "-buffer",
    cmd = [[lua require("jdtls").extract_constant()]]
  })
  command.create({
    name = "JdtExtractConstantRange",
    option = "-buffer",
    cmd = [[lua require("jdtls").extract_constant(true)]]
  })
  command.create({
    name = "JdtExtractMethod",
    option = "-buffer",
    cmd = [[lua require("jdtls").extract_method(true)]]
  })
  command.create({
    name = "JdtTestClass",
    option = "-buffer",
    cmd = [[lua require("jdtls").test_class(true)]]
  })
  command.create({
    name = "JdtTestNearestMethod",
    option = "-buffer",
    cmd = [[lua require("jdtls").test_nearest_method(true)]]
  })
end

return M
