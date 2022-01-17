local M = {}

function M.attach()
  require("lib.command").group({
    prefix = "Jdt",
    buf = true,
    cmds = {
      { name = "OrganizeImports", cmd = require("jdtls").organize_imports },
      { name = "ExtractVariable", cmd = require("jdtls").extract_variable },
      {
        name = "ExtractVariableRange",
        cmd = function()
          require("jdtls").extract_variable(true)
        end,
      },
      { name = "ExtractConstant", cmd = require("jdtls").extract_constant },
      {
        name = "ExtractConstantRange",
        cmd = function()
          require("jdtls").extract_constant(true)
        end,
      },
      {
        name = "ExtractMethod",
        cmd = function()
          require("jdtls").extract_method(true)
        end,
      },
      {
        name = "TestClass",
        cmd = function()
          require("jdtls").test_class(true)
        end,
      },
      {
        name = "TestNearestMethod",
        cmd = function()
          require("jdtls").test_nearest_method(true)
        end,
      },
    },
  })
end

return M
