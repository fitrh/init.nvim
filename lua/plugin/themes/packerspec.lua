local THEME = os.getenv("NVIM_COLORSCHEME") or "tokyonight"
local module = ("plugin.themes.%s.packerspec"):format(THEME)
local ok, result = pcall(require, module)

return ok and result
