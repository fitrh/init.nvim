local config = require("kommentary.config")
local on_lang = config.configure_language

config.use_extended_mappings()

on_lang("c", {
  prefer_multi_line_comments = true,
})

on_lang("lua", {
  prefer_single_line_comments = true,
})
