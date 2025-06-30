local set = vim.api.nvim_set_option_value
set("winhighlight", "Search:None", { scope = "local", win = 0 }) -- avoid higlighting search pattern match
