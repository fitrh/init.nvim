local command = require("lib.command")

-- dir helper
command.create({ name = "MakeDir", cmd = [[lua require("helper.dir").mk()]] })

-- tmux helper
command.group({
  prefix = "TmuxMove",
  create = {
    { name = "H", cmd = [[lua require("helper.tmux").move("h")]] },
    { name = "J", cmd = [[lua require("helper.tmux").move("j")]] },
    { name = "K", cmd = [[lua require("helper.tmux").move("k")]] },
    { name = "L", cmd = [[lua require("helper.tmux").move("l")]] },
  },
})

-- zen helper
command.group({
  prefix = "ZenToggle",
  create = {
    { cmd = [[lua require("helper.zen").toggle()]] },
    {
      name = "Full",
      cmd = [[lua require("helper.zen").toggle({ laststatus = true, })]],
    },
  },
})
