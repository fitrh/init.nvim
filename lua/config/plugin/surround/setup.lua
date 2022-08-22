local config = {}

config.keymaps = {
  normal = "sa",
  normal_cur = "sac",
  normal_line = "sal",
  normal_cur_line = "saC",
  delete = "sd",
  change = "sc",
}

require("nvim-surround").setup(config)
