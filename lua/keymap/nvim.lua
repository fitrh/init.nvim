local keymap = require("lib.keymap")
local on = keymap.on_press
local lead = keymap.on_press_leader
local opt = keymap.opt

keymap.bind({
  -- TODO: add reload config keymap

  -- disable arrow key
  on("<Up>"):disable(),
  on("<Up>", "i"):disable(),
  on("<Down>"):disable(),
  on("<Down>", "i"):disable(),
  on("<Left>"):disable(),
  on("<Left>", "i"):disable(),
  on("<Right>"):disable(),
  on("<Right>", "i"):disable(),

  -- prevent entering ex-mode
  on("gQ", "n"):disable(),
  on("<M-Q>"):disable(),

  -- easy escape
  on("<M-q>"):send("<Esc>"),
  on("<M-q>", "s"):send("<Esc>"),
  on("<M-q>", "i"):send("<Esc>"),
  on("<M-q>", "c"):send("<Esc>"),
  on("<M-q>", "t"):send([[<C-\><C-n>]]),

  -- easy save & quit
  lead("<Space>"):exec("update"),
  lead(";"):exec("x"),
  lead("'"):exec("wall"),
  on("[q"):exec("q"),
  on("[Q"):exec("xall"),

  --- buffer
  -- next & previous buffer
  on("<S-Tab>", "n"):exec("bprevious"),
  on("<Tab>", "n"):exec("bnext"),
  -- close buffer without close window
  lead("bq", "n"):exec("enew<BAR>bdelete #"),
  -- delete current buffer and move to the previous buffer
  lead("bd", "n"):exec("bprevious<BAR>bdelete #"),

  -- toggle cursorline or cursorcolumn
  on("<C-c>c", "n"):exec("set cursorcolumn!"),
  on("<C-c>l", "n"):exec("set cursorline!"),

  -- toggle number
  lead("nn"):exec("set relativenumber!"),
  lead("ln"):exec("set number!"),

  -- cursor movements
  on("H"):send("^"),
  on("L"):send("g_"),
  on("<C-e>", "i"):send("<C-o>A"),

  -- add line below / above current line
  on("<C-l>j", "i"):send("<C-o>o"),
  on("<C-l>k", "i"):send("<C-o>O"),

  --- window
  -- easy next window jumping
  on("<M-Tab>", "n"):send("<C-w>w"),
  -- easy split
  lead("h", "n"):exec("split"),
  lead("v", "n"):exec("vsplit"),
  on("Zh", "n"):exec("leftabove vsplit"),
  on("Zj", "n"):exec("belowright split"),
  on("Zk", "n"):exec("aboveleft split"),
  on("Zl", "n"):exec("rightbelow vsplit"),
  -- resize vertical split
  lead(".", "n"):send("<C-w>>"),
  lead(",", "n"):send("<C-w><"),
  -- resize horizontal split
  lead("=", "n"):send("<C-w>+"),
  lead("-", "n"):send("<C-w>-"),

  -- open terminal
  on("<M-`>"):exec("split term://$SHELL"),

  --- search Behaviour
  -- Map "/" to Search current selected text
  on("/", "v"):send('y/<C-r>"<CR>'),
  -- centering window when hit n/N
  on("n", "n"):send("mnnzz"),
  on("N", "n"):send("mnNzz"),
  -- if hlsearch is active, <CR> to clear it, otherwise <CR> is <CR>
  on("<CR>")
    :send('v:hlsearch ? "<Cmd>nohlsearch<CR>" : "<CR>"')
    :with(opt():noremap():expr()),

  -- move Line
  on("<C-j>", "n"):exec("m .+1"),
  on("<C-j>", "i"):exec("m .+1"),
  on("J", "v"):send(":m '>+1<CR>gv=gv"):with(opt():noremap():silent()),
  on("<C-k>", "n"):exec("m .-2"),
  on("<C-k>", "i"):exec("m .-2"),
  on("K", "v"):send(":m '<-2<CR>gv=gv"):with(opt():noremap():silent()),

  -- join lines without changing cursor position
  on("J", "n"):send("mzJ`z"),

  -- easy select-all
  on("<C-a>", "n"):send("ggVG"):with(opt():noremap():silent()),
  on("<C-a>", "i"):send("<Esc>ggVG"):with(opt():noremap():silent()),

  -- tab page
  lead("t", "n"):exec("tabnew"),
  on("<M-[>", "n"):exec("tabprevious"),
  on("<M-]>", "n"):exec("tabnext"),
  lead("[", "n"):exec("-tabmove"),
  lead("]", "n"):exec("+tabmove"),

  -- Paste-Yank behavior
  -- By default, in visual-line mode, the selected line will be yanked,
  -- and replace the previous yanked line. This map to imporve that behaviour,
  -- after paste, select the yanked line, so it's easy to yank that line again
  on("p", "v"):send("pgv"),
  -- yank-Paste from clipboard
  lead("p", "n"):send('"+p'),
  lead("p", "v"):send('"+p'),
  lead("P", "n"):send('"+P'),
  lead("P", "v"):send('"+P'),
  lead("y", "n"):send('"+y'),
  lead("y", "v"):send('"+y'),
  lead("Y", "n"):send('"+y$'),
  lead("d", "v"):send('"+d'),

  -- reselect indented line
  on("<", "v"):send("<gv"),
  on(">", "v"):send(">gv"),
  on("=", "v"):send("=gv"),
  on("<BS>", "v"):send("<gv"),
  on("<TAB>", "v"):send(">gv"),
}, {
  options = opt():noremap(),
})
