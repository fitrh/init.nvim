local config = require("kommentary.config")
local on_lang = config.configure_language

config.use_extended_mappings()

on_lang("default", {
  single_line_comment_string = "auto",
  multi_line_comment_strings = "auto",
  hook_function = function()
    if package.loaded["ts_context_commentstring"] then
      require("ts_context_commentstring.internal").update_commentstring()
    end
  end,
})

on_lang("c", {
  prefer_multi_line_comments = true,
})

on_lang("lua", {
  prefer_single_line_comments = true,
})
