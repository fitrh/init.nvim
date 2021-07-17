local autopairs = require("nvim-autopairs")
local compe = require("nvim-autopairs.completion.compe")

autopairs.setup({
  -- check_ts = true,
  fast_wrap = {},
})

compe.setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true -- it will auto insert `(` after select function or method item
})
