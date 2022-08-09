local icons = {}

for kind, value in pairs(require("const.LSP_KIND").Symbol) do
  icons[kind] = ("%s "):format(value.icon)
end

require("nvim-navic").setup({
  icons = icons,
  separator = "  ",
  depth_limit_indicator = "…",
})
