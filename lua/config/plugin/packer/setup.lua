local M = {}

M.init = {
  git = {
    clone_timeout = 180, -- Timeout, in seconds
  },
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  profile = {
    enable = true,
    -- integer in milliseconds, plugins which load faster than this
    -- won't be shown in profile output
    threshold = 1,
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
