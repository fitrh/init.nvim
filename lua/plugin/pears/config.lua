local pears = require("pears")
local rule = require("pears.rule")

pears.setup(function(conf)
  conf.preset "tag_matching"
  conf.remove_pair_on_outer_backspace(false)
  conf.pair([["]], {
    close = [["]],
    should_expand = rule.not_(rule.start_of_context "[a-zA-Z]")
  })
end)
