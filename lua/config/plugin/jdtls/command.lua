local M = {}

function M.attach(jdtls, bufnr)
  require("sugar.command").group({
    prefix = "Jdt",
    buf = bufnr,
    cmds = {
      {
        name = "BuildProjects",
        opts = { nargs = "?" },
        cmd = function(opts)
          jdtls.build_projects(opts.fargs[1])
        end,
      },
      { name = "OrganizeImports", cmd = jdtls.organize_imports },
      { name = "ExtractVariable", cmd = jdtls.extract_variable },
      {
        name = "ExtractVariableRange",
        cmd = function()
          jdtls.extract_variable(true)
        end,
      },
      { name = "ExtractConstant", cmd = jdtls.extract_constant },
      {
        name = "ExtractConstantRange",
        cmd = function()
          jdtls.extract_constant(true)
        end,
      },
      {
        name = "ExtractMethod",
        cmd = function()
          jdtls.extract_method(true)
        end,
      },
      {
        name = "TestClass",
        cmd = function()
          jdtls.test_class(true)
        end,
      },
      {
        name = "TestNearestMethod",
        cmd = function()
          jdtls.test_nearest_method(true)
        end,
      },
      {
        name = "UpdateProjectsConfig",
        opts = { nargs = "?" },
        cmd = function(opts)
          jdtls.update_projects_config(opts.fargs[1])
        end,
      },
    },
  })
end

return M
