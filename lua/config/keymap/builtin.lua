local keymap = require("sugar.keymap")
local map, mode, modifier = keymap.map, keymap.mode, keymap.modifier
local nop, leader, ex = modifier.nop, modifier.leader, modifier.ex
local n, i, v, s, c, t =
  mode.normal, mode.insert, mode.visual, mode.select, mode.cmd, mode.terminal

keymap.bind({
  -- TODO: add reload config keymap

  -- disable arrow key
  nop(map("<Up>")),
  nop(i(map("<Up>"))),
  nop(map("<Down>")),
  nop(i(map("<Down>"))),
  nop(map("<Left>")),
  nop(i(map("<Left>"))),
  nop(map("<Right>")),
  nop(i(map("<Right>"))),

  -- g{j,k} move to the first non-blank character of the line
  n(map("gj", "gj^")),
  n(map("gk", "gk^")),

  -- prevent entering ex-mode
  nop(map("gQ")),
  nop(map("<M-Q>")),

  -- easy escape
  map("<M-q>", "<Esc>"),
  s(map("<M-q>", "<Esc>")),
  i(map("<M-q>", "<Esc>")),
  c(map("<M-q>", "<Esc>")),
  t(map("<M-q>", [[<C-\><C-n>]])),
  t(map("<Esc>", [[<C-\><C-n>]])),

  -- easy save & quit
  map(leader("<Space>"), ex("update")),
  map(leader(";"), ex("x")),
  map(leader("'"), ex("wall")),
  map("[q", ex("q")),
  map("[Q", ex("xall")),

  -- cmdline without arrows and tab
  nop(c(map("<Tab>"))),
  nop(c(map("<S-Tab>"))),
  c(map("<C-a>", "<Home>")),
  c(map("<C-f>", "<Right>")),
  c(map("<C-b>", "<Left>")),
  c(map("<M-f>", "<S-Right>")),
  c(map("<M-b>", "<S-Left>")),
  c(map("<C-p>", "<Up>")),
  c(map("<C-n>", "<Down>")),
  c(map("<C-k>", "<Up>")),
  c(map("<C-j>", "<Down>")),

  --- buffer
  n(map("<C-w>Q", ex("bdelete"))),
  -- next & previous buffer
  n(map("<S-Tab>", ex("bprevious"))),
  n(map("<Tab>", ex("bnext"))),
  -- close buffer without close window
  n(map("<C-w>C", ex("enew<BAR>bdelete #"))),
  -- delete current buffer and move to the previous buffer
  n(map("<C-w>B", ex("bprevious<BAR>bdelete #"))),

  -- toggle cursorline or cursorcolumn
  n(map("<C-c>c", ex("setlocal cursorcolumn!"))),
  n(map("<C-c>l", ex("setlocal cursorline!"))),

  -- toggle number
  map(leader("nn"), ex("setlocal relativenumber!")),
  map(leader("ln"), ex("setlocal number!")),

  -- cursor movements
  map("H", "^"), -- To the first non-blank character of the line
  map("L", "g_"), -- To the last non-blank character of the line
  -- a la GNU Readline
  i(map("<C-b>", "<Left>")), -- cursor one character left
  i(map("<C-e>", "<End>")), -- cursor to the end of line
  i(map("<C-f>", "<Right>")), -- cursor one character right
  i(map("<C-a>", "<Home>")), -- cursor to the start of line

  --- window
  -- easy next window jumping
  n(map("<M-Tab>", "<C-w>w")),
  -- create new split window
  n(map("<C-w>S", ex("new"))),
  n(map("<C-w>V", ex("vnew"))),
  -- open current window as a new tabpage
  n(map("<C-w>gt", ex("tabe %"))),
  n(map("<C-w>gT", ex("-tabe %"))),
  -- easy split
  n(map("Zh", ex("leftabove vsplit"))),
  n(map("Zj", ex("belowright split"))),
  n(map("Zk", ex("aboveleft split"))),
  n(map("Zl", ex("rightbelow vsplit"))),
  -- open terminal buffer at the bottom with 14 rows height
  n(map("<M-`>", ex("botright 14split term://$SHELL"))),

  --- search Behaviour
  -- Map "/" to include the last search pattern
  n(map("/", "/<C-r>/")),
  -- Map "/" in visual mode to search current selected text
  v(map("/", [[y/<C-r>"<CR>]])),
  -- centering window when hit n/N
  n(map("n", "mnnzz")),
  n(map("N", "mnNzz")),
  -- if hlsearch is active, <CR> to clear it, otherwise <CR> is <CR>
  n(map("<CR>", function()
    if vim.v.hlsearch == 1 then
      return "<Cmd>nohlsearch<CR>"
    end
    return "<CR>"
  end, { expr = true })),

  -- moves line
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
  n(map("<C-w>O", ex("tabonly"))),
  n(map(leader("t"), ex("tabnew"))),
  n(map(leader("["), ex("-tabmove"))),
  n(map(leader("]"), ex("+tabmove"))),

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

  -- reselect indented line
  v(map("<", "<gv")),
  v(map(">", ">gv")),
  v(map("=", "=gv")),
  v(map("<BS>", "<gv")),
  v(map("<TAB>", ">gv")),
})
