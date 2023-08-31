local M = {}

M.init = {
  git = {
    clone_timeout = 180, -- Timeout, in seconds
  },
  display = {
    open_cmd = "enew",
    prompt_border = "solid",
    keybindings = { quit = "<M-q>" },
  },
}

function M.use(plugins)
  return function(use)
    use({ "wbthomason/packer.nvim", opt = true })
    for _, plugin in ipairs(plugins) do
      use(plugin)
    end
  end
end

return M
