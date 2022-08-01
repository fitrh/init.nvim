local config = {}

config.markdown = {
  headline_highlights = {},
  dash_string = "━",
  quote_string = "▓",
  fat_headlines = false,
}

require("headlines").setup(config)
