local config = {}

config.markdown = {
  headline_highlights = {
    "HeadLine1",
    "HeadLine2",
    "HeadLine3",
    "HeadLine4",
    "HeadLine5",
    "HeadLine6",
  },
  dash_string = "━",
  quote_string = "▓",
  fat_headlines = false,
}

require("headlines").setup(config)
