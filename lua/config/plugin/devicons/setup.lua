local devicons = require("nvim-web-devicons")
devicons.set_default_icon("", "#6d8086")

local icon = {}
icon.default = devicons.get_icons()
icon.override = {
  [".envrc"] = icon.default[".env"],
  ["build.gradle"] = { icon = "ﳄ", color = "#02303a", name = "Gradle" },
  ["Cargo.toml"] = { icon = "", color = "#dea584", name = "CargoTOML" },
  ["Cargo.lock"] = { icon = "", color = "#9e5f27", name = "CargoLock" },
  config = { icon = "", color = "#ececec", name = "Config" },
  fish = { icon = "", color = "#59ccff", name = "Fish" },
  gradlew = { icon = "ﳄ", name = "Gradle" },
  ["gradlew.bat"] = { icon = "ﳄ", name = "Gradle" },
  javascript = { icon = "", color = "#8fa959", name = "JavaScript" },
  make = { icon = "", color = "#e37933", name = "Make" },
  ["package.json"] = { icon = "", color = "#8fa959", name = "PkgJSON" },
  python = icon.default["py"],
  ruby = icon.default["rb"],
  ["settings.gradle"] = { icon = "ﳄ", name = "Gradle" },
  txt = { icon = "", color = "#6a9fb5", name = "TXT" },
  v = { icon = "", color = "#5d88c0", name = "Vlang" },
  vlang = { icon = "", name = "Vlang" },
  vv = { icon = "", name = "Vlang" },
  vsh = { icon = "", name = "Vlang" },
}

devicons.setup({
  override = icon.override,
  default = true,
})
