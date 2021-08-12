local pears = require("pears")
local rule = require("pears.rule")

pears.setup(function(conf)
  conf.preset "tag_matching"
  conf.remove_pair_on_outer_backspace(false)
  conf.on_enter(function(pears_handle)
    if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
      return vim.fn["compe#confirm"]("<CR>")
    else
      pears_handle()
    end
  end)
  -- Don't expand a double quote if it comes after an alpha character
  conf.pair([["]], {
    close = [["]],
    should_expand = rule.not_(rule.start_of_context "[a-zA-Z]")
  })
end)
