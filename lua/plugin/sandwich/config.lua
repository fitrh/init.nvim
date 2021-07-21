local recipes = {
  {
    buns = { "\\s\\+", "\\s\\+" },
    input = { " " },
    kind = { "delete", "replace", "query" },
    regex = 1
  },
  {
    action = { "add" },
    buns = { "", "" },
    input = { "\r" },
    linewise = 1,
    motionwise = { "line" }
  },
  {
    buns = { "^$", "^$" },
    input = { "\r" },
    linewise = 1,
    regex = 1
  },
  {
    buns = { "<", ">" },
    expand_range = 0
  },
  {
    buns = { '"', '"' },
    expand_range = 0,
    linewise = 0,
    nesting = 0,
    quoteescape = 1
  },
  {
    buns = { "'", "'" },
    expand_range = 0,
    linewise = 0,
    nesting = 0,
    quoteescape = 1
  },
  {
    buns = { "`", "`" },
    expand_range = 0,
    linewise = 0,
    nesting = 0,
    quoteescape = 1
  },
  {
    buns = { "{", "}" },
    nesting = 1,
    skip_break = 1
  },
  {
    buns = { "[", "]" },
    nesting = 1
  },
  {
    buns = { "(", ")" },
    nesting = 1
  },
  {
    action = { "add" },
    buns = "sandwich#magicchar#t#tag()",
    input = { "t", "T" },
    kind = { "add" },
    listexpr = 1
  },
  {
    action = { "add" },
    buns = "sandwich#magicchar#t#tag()",
    input = { "T" },
    kind = { "replace" },
    listexpr = 1
  },
  {
    action = { "add" },
    buns = "sandwich#magicchar#t#tagname()",
    input = { "t" },
    kind = { "replace" },
    listexpr = 1
  },
  {
    expr_filter = { 'operator#sandwich#kind() !=# "replace"' },
    external = {
      "<80><fd>S(textobj-sandwich-tag-i)",
      "<80><fd>S(textobj-sandwich-tag-a)"
    },
    input = { "t", "T" },
    kind = { "delete", "textobj" },
    linewise = 1,
    noremap = 0
  },
  {
    expr_filter = { 'operator#sandwich#kind() ==# "replace"' },
    external = {
      "<80><fd>S(textobj-sandwich-tag-i)",
      "<80><fd>S(textobj-sandwich-tag-a)"
    },
    input = { "T" },
    kind = { "replace", "query" },
    noremap = 0
  },
  {
    expr_filter = { 'operator#sandwich#kind() ==# "replace"' },
    external = {
      "<80><fd>S(textobj-sandwich-tagname-i)",
      "<80><fd>S(textobj-sandwich-tagname-a)"
    },
    input = { "t" },
    kind = { "replace", "textobj" },
    noremap = 0
  },
  {
    action = { "add" },
    buns = { "sandwich#magicchar#f#fname()", '")"' },
    expr = 1,
    input = { "f" },
    kind = { "add", "replace" }
  },
  {
    external = {
      "<80><fd>S(textobj-sandwich-function-ip)",
      "<80><fd>S(textobj-sandwich-function-i)"
    },
    input = { "f" },
    kind = { "delete", "replace", "query" },
    noremap = 0
  },
  {
    external = {
      "<80><fd>S(textobj-sandwich-function-ap)",
      "<80><fd>S(textobj-sandwich-function-a)"
    },
    input = { "F" },
    kind = { "delete", "replace", "query" },
    noremap = 0
  },
  {
    action = { "add" },
    buns = 'sandwich#magicchar#i#input("operator")',
    input = { "i" },
    kind = { "add", "replace" },
    listexpr = 1
  },
  {
    buns = 'sandwich#magicchar#i#input("textobj", 1)',
    input = { "i" },
    kind = { "delete", "replace", "query" },
    listexpr = 1,
    regex = 1
  },
  {
    action = { "add" },
    buns = 'sandwich#magicchar#i#lastinput("operator", 1)',
    input = { "I" },
    kind = { "add", "replace" },
    listexpr = 1
  },
  {
    buns = 'sandwich#magicchar#i#lastinput("textobj")',
    input = { "I" },
    kind = { "delete", "replace", "query" },
    listexpr = 1,
    regex = 1
  },
  {
    buns = {"{ ", " }"},
    nesting= 1,
    match_syntax= 1,
    kind= {"add", "replace"},
    action= {"add"},
    input= {"{"}
  },
  {
    buns = {"[ ", " ]"},
    nesting= 1,
    match_syntax= 1,
    kind= {"add", "replace"},
    action= {"add"},
    input= {"["}
  },
  {
    buns = {"( ", " )"},
    nesting= 1,
    match_syntax= 1,
    kind= {"add", "replace"},
    action= {"add"},
    input= {"("}
  },
  {
    buns = {[[{\s*]], [[\s*}]]},
    nesting= 1,
    regex= 1,
    match_syntax= 1,
    kind= {"delete", "replace", "textobj"},
    action= {"delete"},
    input= {"{"}
  },
  {
    buns = {[[\[\s*]], [[\s*\]\]]},
    nesting= 1,
    regex= 1,
    match_syntax= 1,
    kind= {"delete", "replace", "textobj"},
    action= {"delete"},
    input= {"["}
  },
  {
    buns = {[[(\s*]], [[\s*)]]},
    nesting= 1,
    regex= 1,
    match_syntax= 1,
    kind= {"delete", "replace", "textobj"},
    action= {"delete"},
    input= {"("}
  },
}

local g = vim.g
g["sandwich#recipes"] = recipes
