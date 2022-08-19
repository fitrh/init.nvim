local config = {}

config.keymaps = {
  insert = "<C-g>s",
  insert_line = "<C-g>S",
  normal = "sa",
  normal_cur = "sas",
  normal_line = "saS",
  normal_cur_line = "sAS",
  visual = "S",
  visual_line = "gS",
  delete = "sd",
  change = "sc",
}

require("nvim-surround").setup(config)
