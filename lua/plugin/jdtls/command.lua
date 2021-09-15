local M = {}

function M.attach(client, bufnr)
  require("lib.command").group({
    prefix = "Jdt",
    option = "-buffer",
    create = {
      { name = "CodeAction", cmd = [[lua require("jdtls").code_action()]] },
      {
        name = "CodeActionRange",
        cmd = [[lua require("jdtls").code_action(true)]],
      },
      {
        name = "JdtCodeActionRefactor",
        cmd = [[lua require("jdtls").code_action(false, "refactor")]],
      },
      {
        name = "OrganizeImports",
        cmd = [[lua require("jdtls").organize_imports()]],
      },
      {
        name = "ExtractVariable",
        cmd = [[lua require("jdtls").extract_variable()]],
      },
      {
        name = "ExtractVariableRange",
        cmd = [[lua require("jdtls").extract_variable(true)]],
      },
      {
        name = "ExtractConstant",
        cmd = [[lua require("jdtls").extract_constant()]],
      },
      {
        name = "ExtractConstantRange",
        cmd = [[lua require("jdtls").extract_constant(true)]],
      },
      {
        name = "ExtractMethod",
        cmd = [[lua require("jdtls").extract_method(true)]],
      },
      { name = "TestClass", cmd = [[lua require("jdtls").test_class(true)]] },
      {
        name = "TestNearestMethod",
        cmd = [[lua require("jdtls").test_nearest_method(true)]],
      },
    },
  })
end

return M
