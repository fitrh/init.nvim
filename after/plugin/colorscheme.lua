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

local NVIM_COLORSCHEME = os.getenv("NVIM_COLORSCHEME")
local colorscheme = colorschemes[NVIM_COLORSCHEME]
if not colorscheme then
  NVIM_COLORSCHEME = default
  colorscheme = colorschemes[NVIM_COLORSCHEME]
end

vim.api.nvim_exec_autocmds("ColorSchemePre", {})
vim.api.nvim_exec_autocmds("User", { pattern = colorscheme })
vim.api.nvim_exec_autocmds("ColorScheme", { pattern = NVIM_COLORSCHEME })
