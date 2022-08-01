local extension = {
  h = "c",
  hpp = "cpp",
  v = "vlang",
  vv = "vlang",
  vsh = "vlang",
}

local filename = {
  [".env"] = "config",
  [".envrc"] = "config",
}

vim.filetype.add({
  extension = extension,
  filename = filename,
})
