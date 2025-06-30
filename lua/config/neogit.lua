local config = {}
config.mappings = {
  status = {
    ["o"] = function (args)
      vim.print("Status")
      vim.print(args)
    end
  },
  commit_view = {
    ["O"] = function (args)
      vim.print("Commit View")
      vim.print(args)
    end
  }
}

require("neogit").setup(config)
