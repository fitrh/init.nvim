local config = {}

config.markdown = {
  headline_highlights = {
    "Headline",
    "Headline2",
    "Headline3",
    "Headline4",
    "Headline5",
    "Headline6",
  },
  dash_string = "━",
  quote_string = "▓",
  fat_headlines = false,
}

require("headlines").setup(config)
