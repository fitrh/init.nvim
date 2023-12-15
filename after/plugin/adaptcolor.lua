local a = vim.api
local group = a.nvim_create_augroup("adaptcolor", {})

a.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = function(_)
    local normal = a.nvim_get_hl(0, { name = "Normal", link = false })
    if not normal or not normal.bg or not normal.fg then
      return
    end

    local bg = string.format("#%06x", normal.bg)
    local fg = string.format("#%06x", normal.fg)

    local exec = os.execute
    if os.getenv("TMUX") then
      -- NOTE: tmux requires `set -g allow-passthrough on`
      exec('printf "\\ePtmux;\\e\\033]11;' .. bg .. '\\007\\e\\\\"')
      exec('printf "\\ePtmux;\\e\\033]12;' .. fg .. '\\007\\e\\\\"')
    else
      exec('printf "\\033]11;' .. bg .. '\\007"')
      exec('printf "\\033]12;' .. fg .. '\\007"')
    end
  end,
})

a.nvim_create_autocmd("VimLeavePre", {
  group = group,
  callback = function(_)
    if os.getenv("TMUX") then
      os.execute('printf "\\ePtmux;\\e\\033]111\\007\\e\\\\"')
      os.execute('printf "\\ePtmux;\\e\\033]112\\007\\e\\\\"')
      return
    end

    os.execute('printf "\\033]111\\007"')
    os.execute('printf "\\033]112\\007"')
  end,
  once = true,
})
