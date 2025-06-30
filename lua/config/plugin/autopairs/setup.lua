local autopairs = require("nvim-autopairs")

autopairs.setup({
  check_ts = true,
  fast_wrap = {},
})

-- local Rule = require("nvim-autopairs.rule")
-- local npairs = require("nvim-autopairs")
-- npairs.add_rule(Rule("(", ")"):replace_endpair(function()
--   return ")<Right>"
-- end):set_end_pair_length(0))

-- vim.api.nvim_create_autocmd("User", {
--   group = vim.api.nvim_create_augroup("autopairs_cmp", {}),
--   pattern = "CmpConfirmDone",
--   callback = function(e)
--     require("nvim-autopairs.completion.cmp").on_confirm_done()(e.data)
--   end,
-- })
