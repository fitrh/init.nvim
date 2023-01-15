local default = "tokyonight"
local colorschemes = {
  ["doom-one"] = "DoomOnePre",
  github = "GithubPre",
  gruvbox = "GruvboxPre",
  kanagawa = "KanagawaPre",
  material = "MaterialPre",
  ["rose-pine"] = "RosePinePre",
  tokyonight = "TokyoNightPre",
}

local NVIM_COLORSCHEME = os.getenv("NVIM_COLORSCHEME") or default
vim.api.nvim_exec_autocmds("ColorSchemePre", {})
vim.api.nvim_exec_autocmds("User", { pattern = colorschemes[NVIM_COLORSCHEME] })
vim.api.nvim_exec_autocmds("ColorScheme", { pattern = NVIM_COLORSCHEME })
