local devicons = require("nvim-web-devicons")

devicons.set_default_icon("", "#6d8086")
local icons = devicons.get_icons()

devicons.setup({
  override = {
    ["Cargo.toml"] = {
      icon = "",
      color = "#dea584",
      name = "CargoTOML",
    },
    ["Cargo.lock"] = {
      icon = "",
      color = "#9e5f27",
      name = "CargoLock",
    },
    config = {
      icon = "",
      color = "#ECECEC",
      name = "Config",
    },
    javascript = {
      icon = "",
      color = "#8fa959",
      name = "JavaScript",
    },
    log = {
      icon = "",
      color = "#41535b",
      name = "Log",
    },
    make = {
      icon = "",
      color = "#e37933",
      name = "Make",
    },
    ["package.json"] = {
      icon = "",
      color = "#8fa959",
      name = "JavaScript",
    },
    python = icons["py"],
    ruby = icons["rb"],
    txt = {
      icon = "",
      color = "#6a9fb5",
      name = "TXT",
    },
    v = {
      icon = "",
      color = "#5d88c0",
      name = "V",
    },
    vlang = {
      icon = "",
      color = "#5d88c0",
      name = "Vlang",
    },
    vv = {
      icon = "",
      color = "#5d88c0",
      name = "Vv",
    },
    vsh = {
      icon = "",
      color = "#5d88c0",
      name = "Vsh",
    },
  },
  default = true,
})
