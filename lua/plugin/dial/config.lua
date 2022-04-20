local augend = require("dial.augend")

require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.binary,
    augend.integer.alias.decimal,
    augend.integer.alias.decimal_int,
    augend.integer.alias.octal,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
    augend.constant.new({
      elements = { "and", "or" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "is", "not" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "&", "|" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "+", "-", "*", "/", "%" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { ">", "<" },
      cyclic = true,
    }),
    augend.constant.new({
      elements = { ">=", "<=" },
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "==", "!=" },
      word = false,
      cyclic = true,
    }),
    augend.semver.alias.semver,
    augend.paren.alias.quote,
    augend.paren.alias.brackets,
    augend.date.alias["%Y/%m/%d"],
    augend.date.alias["%m/%d/%Y"],
    augend.date.alias["%d/%m/%Y"],
    augend.date.alias["%m/%d/%y"],
    augend.date.alias["%d/%m/%y"],
    augend.date.alias["%m/%d"],
    augend.date.alias["%-m/%-d"],
    augend.date.alias["%Y-%m-%d"],
    augend.date.alias["%H:%M:%S"],
    augend.date.alias["%H:%M"],
  },
})
