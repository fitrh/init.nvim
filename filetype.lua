local extension = {
  h = "c",
  hpp = "cpp",
  log = "log",
  v = "vlang",
  vv = "vlang",
  vsh = "vlang",
}

local filename = {
  [".env"] = "config",
  [".envrc"] = "config",
  [".yamlfmt"] = "yaml",
}

vim.filetype.add({
  extension = extension,
  filename = filename,
})
