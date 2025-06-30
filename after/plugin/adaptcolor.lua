-- Use OSC escape sequence to set terminal color to follow nvim color
-- Currently set OSC 10, 11, 12 (fg, bg, cursor)
local a = vim.api
local group = a.nvim_create_augroup("adaptcolor", {})

-- TODO: Wrap the callback with `vim.schedule_wrap`
-- TODO: Replace `os.execute('printf...` with `io.write`
-- TODO: Fix https://github.com/neovim/neovim/pull/31350
-- TODO: set color0 - color15 using terminal_color_*
-- FIXME: On focused window, the terminal color doesn't adapted
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
      exec('printf "\\033Ptmux;\\033\\033]10;' .. fg .. '\\007\\033\\\\"')
      exec('printf "\\033Ptmux;\\033\\033]11;' .. bg .. '\\007\\033\\\\"')
      exec('printf "\\033Ptmux;\\033\\033]12;' .. fg .. '\\007\\033\\\\"')
    else
      exec('printf "\\033]10;' .. fg .. '\\007"')
      exec('printf "\\033]11;' .. bg .. '\\007"')
      exec('printf "\\033]12;' .. fg .. '\\007"')
    end
  end,
})

-- TODO: Handle `Vim{Resume,Suspend}`?
a.nvim_create_autocmd("UILeave", {
  group = group,
  callback = function(_)
    if os.getenv("TMUX") then
      os.execute('printf "\\033Ptmux;\\e\\033]110\\007\\033\\\\"')
      os.execute('printf "\\033Ptmux;\\e\\033]111\\007\\033\\\\"')
      os.execute('printf "\\033Ptmux;\\e\\033]112\\007\\033\\\\"')
      return
    end

    os.execute('printf "\\033]110\\007"')
    os.execute('printf "\\033]111\\007"')
    os.execute('printf "\\033]112\\007"')
  end,
  once = true,
})
