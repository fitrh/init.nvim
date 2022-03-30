local command = require("lib.command")

-- dir helper
command.add("MakeDir", function()
  require("helper.dir").mk()
end)

-- tmux helper
command.group({
  prefix = "TmuxMove",
  cmds = {
    {
      name = "H",
      cmd = function()
        require("helper.tmux").move("h")
      end,
    },
    {
      name = "J",
      cmd = function()
        require("helper.tmux").move("j")
      end,
    },
    {
      name = "K",
      cmd = function()
        require("helper.tmux").move("k")
      end,
    },
    {
      name = "L",
      cmd = function()
        require("helper.tmux").move("l")
      end,
    },
  },
})

-- zen helper
command.group({
  prefix = "ZenToggle",
  cmds = {
    {
      cmd = function()
        require("helper.zen").toggle()
      end,
    },
    {
      name = "Full",
      cmd = function()
        require("helper.zen").toggle({ laststatus = true })
      end,
    },
  },
})
