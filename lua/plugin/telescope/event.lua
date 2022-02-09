require("lib.event.augroup").setup({
  ["OnTelescopePrompt"] = {
    {
      events = "FileType",
      filter = "TelescopePrompt",
      cmd = "set nocursorline",
    },
  },
})
