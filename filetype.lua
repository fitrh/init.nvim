local extension = {
  h = "c",
  hpp = "cpp",
  log = "log",
  plantuml = "plantuml",
  pu = "plantuml",
  puml = "plantuml",
  scfg = "scfg",
  v = "vlang",
  vv = "vlang",
  vsh = "vlang",
}

local filename = {
  [".env"] = "config",
  [".envrc"] = "config",
  [".yamlfmt"] = "yaml",
  readme = "text",
  README = "text",
  todo = "text",
  TODO = "text",
}

vim.filetype.add({
  extension = extension,
  filename = filename,
})
