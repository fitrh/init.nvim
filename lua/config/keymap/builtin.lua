local keymap = require("sugar.keymap")
local map, mode, modifier = keymap.map, keymap.mode, keymap.modifier
local leader, ex = modifier.leader, modifier.ex
local n, i, v, s, c, t =
  mode.normal, mode.insert, mode.visual, mode.select, mode.cmd, mode.terminal

-- TODO: Replace `ex(...)` with `vim.cmd`/`vim.api.nvim_cmd`
-- TODO: Replace `M` with `A` for `Alt` key, follows `src/nvim/tui/input.c`
-- TODO: mark all keys-as-rhs as noremap to prevents future side-effect
local a = vim.api
local cmd = vim.cmd
keymap.bind({
  -- TODO: add reload config keymap

  -- g{j,k} move to the first non-blank character of the line
  n(map("gj", "gj^")), -- expample of keys-as-rhs
  n(map("gk", "gk^")),

  -- useful when on 'select-jump' between snippet nodes by default, s_<CR>
  -- will delete the selection, insert a newline, then enter the insert mode
  s(map("<CR>", "<C-g>s")), -- <C-g>: switch to visual mode, s: subtitue

  -- easy escape in terminal-mode
  -- CTRL-[ is enough
  t(map("<Esc>", [[<C-\><C-n>]])),

  -- easy save & quit
  -- REF: https://github.com/neovim/neovim/pull/20835
  -- map(leader("<Space>"), ex("update ++p")), -- causes statusline redraw
  map(leader(";"), ex("x")),
  map(leader("'"), ex("wall")),
  -- map("[q", ex("q")), -- clash with [q: cprev
  -- map("[Q", ex("xall!")),

  -- cmdline without arrows and tab
  -- moved to cmp config, only disable built-in behavior if there is a completion plugin
  c(map("<C-a>", "<Home>")),
  c(map("<C-f>", function()
    if vim.fn.getcmdpos() == #vim.fn.getcmdline() + 1 then
      return "<C-f>"
    end
    return "<Right>"
  end, { expr = true, noremap = true })),
  c(map("<C-b>", "<Left>")),
  c(map("<M-f>", "<S-Right>")),
  c(map("<M-b>", "<S-Left>")),
  c(map("<C-p>", "<Up>")),
  c(map("<C-n>", "<Down>")),
  c(map("<C-k>", "<Up>")),
  c(map("<C-j>", "<Down>")),

  --- buffer
  n(map("<C-w>Q", cmd.bdelete)),
  -- next & previous buffer
  n(map("<C-p>", function()
    vim.cmd.bprevious({ count = vim.v.count1 })
  end)), -- use vim.cmd/lua-function, imitate `:silent {cmd}<CR>` but does not trigger `Cmdline*` event, avoid statusline flickering on single buffer
  n(map("<C-n>", function()
    vim.cmd.bnext({ count = vim.v.count1 })
  end)), -- do not map <Tab>, since it interpreted as CTRL-I, causing jumping forward jumlist do not works
  -- close buffer without close window
  n(map("<C-w>C", ex("enew<BAR>bdelete #"))),
  -- delete current buffer and move to the previous buffer
  -- n(map("<C-w>B", ex("bprevious<BAR>bdelete #"))),
  n(map("<C-w>B", function()
    local has_next = pcall(vim.cmd.bprevious)
    if not has_next then
      vim.cmd.enew()
    end
    vim.cmd.bdelete("#")
  end)),

  -- toggle cursorline or cursorcolumn
  -- TODO: remove, command is enough
  -- TODO: Replace `<C-c>`, it used by cmdline-window to continue command-line with the command under the cursor
  n(map("<C-c>c", ex("setlocal cursorcolumn!"))),
  n(map("<C-c>l", ex("setlocal cursorline!"))),

  -- TODO: remove, command is enough
  -- toggle number
  map(leader("nn"), ex("setlocal relativenumber!")),
  map(leader("ln"), ex("setlocal number!")),

  -- cursor movements
  -- map("H", "^"), -- To the first non-blank character of the line
  -- map("L", "g_"), -- To the last non-blank character of the line
  -- a la GNU Readline
  i(map("<C-b>", "<Left>")), -- cursor one character backward -- TODO: on the start of the line, <Up>, <End>
  i(map("<M-b>", "<S-Left>")), -- cursor one word backward
  i(map("<C-f>", "<Right>", { noremap = true })), -- cursor one character forward
  i(map("<M-f>", "<S-Right>")), -- cursor one word forward
  i(map("<C-e>", function() -- cursor to the end of line
    if vim.b.lsp_floating_preview then
      vim.schedule(function()
        vim.api.nvim_win_close(vim.b.lsp_floating_preview, false)
      end)
      return
    end

    local row, col = unpack(a.nvim_win_get_cursor(0))
    local rowstr = a.nvim_buf_get_lines(0, row - 1, row, true)[1]

    if rowstr:sub(col + 1, col + 1) == "" then -- EOL
      return "<Down><Home>" -- Move down and go to start of line
    end

    return "<End>"
  end, { expr = true, noremap = true })),
  i(map("<C-a>", function() -- cursor to the start of line
    local _, col = unpack(a.nvim_win_get_cursor(0))
    if col == 0 then -- On the start of line
      return "<Up><End>" -- Move up and go to EOL
    end

    return "<Home>"
  end, { expr = true, noremap = true })),

  --- window
  -- easy next window jumping
  n(map("<M-Tab>", "<C-w>w")),
  -- create new split window
  n(map("<C-w>S", function()
    local height = vim.api.nvim_get_vvar("count")
    if height < 1 then
      height = math.floor(vim.api.nvim_win_get_height(0) * 0.5)
    end
    vim.api.nvim_cmd({ cmd = "new", range = { height } }, {})
  end)),

  n(map("<C-w>V", function()
    local width = vim.api.nvim_get_vvar("count")
    if width == 0 then
      width = math.floor(vim.api.nvim_win_get_width(0) * 0.5)
    end
    vim.api.nvim_cmd({ cmd = "vnew", range = { width } }, {})
  end)),
  -- open current window as a new tabpage
  n(map("<C-w>gt", ex("silent tabe %"))),
  n(map("<C-w>gT", ex("silent -tabe %"))),
  -- easy split -- TODO: support count
  n(map("Zh", ex("leftabove vsplit"))),
  n(map("Zj", ex("belowright split"))),
  n(map("Zk", ex("aboveleft split"))),
  n(map("Zl", ex("rightbelow vsplit"))),
  -- open terminal buffer at the bottom with 14 rows height
  n(map("<M-`>", function()
    local height = a.nvim_get_vvar("count")
    if height < 1 then
      height = math.ceil(vim.o.lines * 0.3) -- 30% of editor height
    end

    local exec = { cmd = "split", args = { "term://$SHELL" } }
    exec.range = { height }
    exec.mods = { split = "botright" }
    a.nvim_cmd(exec, {})
  end)),

  --- search behaviour
  -- Map search commands to include the last search pattern
  -- FIX: `E35: No previous regular expression`
  --      Reproduction:
  --        - `:call setreg('/', [])`
  --        - Press `/`
  n(map("/", function()
    local reg = vim.api.nvim_call_function("getreg", { "/" })
    if reg and reg ~= "" then
      -- NOTE: We can't use `return "/" .. reg` since `<expr>` will evaluate the
      -- string, so if `reg` is a key notation e.g `<CR>` the result will be
      -- whatever `<CR>` expression do, in this case it will execute search
      -- immediately
      return "/<C-r>/"
    end
    return "/"
  end, { expr = true, noremap = true })),
  -- TODO: convert like above
  n(map("?", "?<C-r>/")),
  -- Map search commands in visual mode to search current selected text
  -- TODO: Avoid yanking, possible solutions:
  --         - Use %V ato -> `<Esc>/\\%V
  --         - Use getregion
  --         - Or yank using other register
  v(map("/", [[y/<C-r>"]])), -- TODO: Use https://github.com/neovim/neovim/issues/21676
  v(map("?", [[y?<C-r>"]])), -- TODO: Remove `<CR>` to avoid immediate execution, use */# for immediate execution
  -- centering window when hit n/N
  -- n(map("n", "mnnzz")), -- What 'mn*' does?
  -- n(map("N", "mnNzz")),
  -- if hlsearch is active, <CR> to clear it, otherwise <CR> is ciw
  n(map("<CR>", function()
    -- NOTE: `<C-l>` gives screen flickering since it also redraw the terminal
    if vim.api.nvim_get_vvar("hlsearch") == 1 then
      vim.api.nvim_set_vvar("hlsearch", false) -- SEE: https://github.com/neovim/neovim/pull/25325
      vim.cmd.redrawstatus()
      return "<Ignore>" -- make the above expression executed immediately, SEE: `:h :map-<expr>`
    end

    if
      vim.api.nvim_get_option_value("modifiable", { buf = 0 })
      and vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "" -- need to check so we don't override <CR> for cmdline-window
    then
      return "ciw"
    end

    return "<CR>"
  end, { expr = true, noremap = true })),

  -- moves line
  -- TODO: Remove v_J and v_K as they override the useful built-in keymap
  n(map("<C-j>", ":m .+1<CR>==", { silent = true })),
  i(map("<M-j>", "<Esc>:m .+1<CR>==gi", { silent = true })),
  v(map("J", ":m '>+1<CR>gv=gv", { silent = true })),
  n(map("<C-k>", ":m .-2<CR>==", { silent = true })),
  i(map("<M-k>", "<Esc>:m .-2<CR>==gi", { silent = true })),
  v(map("K", ":m '<-2<CR>gv=gv", { silent = true })),
  -- join lines without changing cursor position
  n(map("J", "'mz' . v:count1 . 'J`z'", { expr = true })),

  -- easy select-all
  n(map("gA", "ggVG", { silent = true })),
  v(map("gA", "ggoG", { silent = true })),

  -- tab page
  n(map("<C-w>O", ex("tabonly"))), -- FIXME: Do nothing for single tabpage, prevents hit-enter
  n(map(leader("t"), ex("tabnew"))),
  n(map(leader("["), function()
    vim.cmd.tabmove("-")
  end)),
  n(map(leader("]"), function()
    vim.cmd.tabmove("+")
  end)),

  -- Paste-Yank behavior
  -- By default, in visual-line mode, the selected line will be yanked,
  -- and replace the previous yanked line. This map to improve that behaviour,
  -- after paste, select the yanked line, so it's easy to yank that line again
  v(map("p", "pgv")),
  -- yank-Paste from clipboard
  n(map(leader("p"), '"+p')),
  v(map(leader("p"), '"+p')),
  n(map(leader("P"), '"+P')),
  v(map(leader("P"), '"+P')),
  n(map(leader("y"), '"+y')),
  v(map(leader("y"), '"+y')),
  n(map(leader("Y"), '"+y$')),
  n(map(leader("d"), '"+d')),

  -- TODO: use black hole register for delete keys if the line is empty line

  -- reselect indented line
  v(map("<", "<gv")),
  v(map(">", ">gv")),
  v(map("=", "=gv")),
  v(map("<BS>", "<gv")),
  v(map("<TAB>", ">gv")),
})
