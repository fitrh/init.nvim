local config = {
  default_file_explorer = false,
  columns = { "permissions", "size", "mtime" },
  win_options = {
    signcolumn = "yes:2",
  },
}

local refresh = vim.schedule_wrap(function()
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_exec_autocmds("BufWritePost", { buffer = buf })
  vim.cmd.redrawstatus()
end)

config.keymaps = {}
config.keymaps.ga = {
  desc = "`git add` entry under cursor",
  callback = function()
    local entry = require("oil").get_cursor_entry()
    require("oil.git").add(entry.name, function(err)
      if not err then
        refresh()
      end
    end)
  end,
}
config.keymaps.gu = {
  desc = "`git restore --staged` entry under cursor",
  callback = function()
    local entry = require("oil").get_cursor_entry()
    local root = require("oil.git").get_root(entry.name)
    if not root then
      vim.print("git root not found")
      return
    end

    local cmd = { "git", "restore", "--staged", entry.name }
    vim.system(cmd, { cwd = root }, function(out)
      if out.code ~= 0 then
        vim.print(out.stderr)
        return
      end
      refresh()
    end)
  end,
}

require("oil").setup(config)
