local parser = require("nvim-treesitter.parsers").get_parser_configs()

parser.v = {
  install_info = {
    url = "https://github.com/nedpals/tree-sitter-v",
    files = { "src/parser.c", "src/scanner.c" },
  },
  filetype = "vlang",
}
