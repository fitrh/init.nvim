local dap = require("dap")

local function map(key, fn)
  vim.api.nvim_set_keymap("n", key, "", {
    callback = function()
      if require("dap").session() then
        fn()
        return
      end
      vim.api.nvim_feedkeys(key, "t", false)
    end,
  })
end
map("dzb", dap.toggle_breakpoint)
map("dzn", dap.continue)
map("dzN", dap.run_last)
map("dzi", dap.step_into)
map("dzI", dap.step_out)
-- TODO: Set up https://github.com/theHamsta/nvim-dap-virtual-text

local a = vim.api
local au = a.nvim_create_autocmd
local augroup = a.nvim_create_augroup

au("FileType", {
  group = augroup("dap_c_codelldb", {}),
  pattern = "c",
  callback = function()
    dap.adapters.codelldb = {
      type = "server",
      port = "11109",
      executable = {
        command = "/Users/fitrh/.local/lib/dap/codelldb/extension/adapter/codelldb",
        args = { "--port", "11109" },
      },
    }
    dap.configurations.c = {
      {
        name = "codelldb: Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          local exe
          vim.ui.input({ prompt = "Executable: " }, function(i)
            exe = i
          end)
          return vim.fn.getcwd() .. "/" .. exe
        end,
        cwd = "${workspaceFolder}",
      },
    }
  end,
})

au("FileType", {
  group = augroup("dap_python", {}),
  pattern = "python",
  callback = function()
    require("dap-python").setup()
  end,
})
