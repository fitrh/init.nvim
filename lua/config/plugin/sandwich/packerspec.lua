return {
  "machakann/vim-sandwich",
  config = function()
    require("config.plugin.sandwich.setup")
  end,
  keys = {
    -- basic add, replace, and delete operator
    { "n", "sa" },
    { "v", "sa" },
    { "n", "sr" },
    { "v", "sr" },
    { "n", "sd" },
    { "v", "sd" },
    -- textobj
    { "v", "ib" },
    { "v", "is" },
    { "v", "ab" },
    { "v", "as" },
    -- textobj tag
    { "v", "it" },
    { "v", "at" },
  },
}
