require("neotest").setup({
  adapters = {
    require("neotest-bash"),
    require("neotest-dart"),
    require("neotest-go"),
    require("neotest-vitest"),
    require("neotest-zig"),
  },
})
