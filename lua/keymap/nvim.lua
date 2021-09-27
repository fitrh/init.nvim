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
  on("Q", "n"):disable(),
  on("gQ", "n"):disable(),
  on("<M-Q>"):disable(),

  -- easy escape
  on("<M-q>"):run("<Esc>"),
  on("<M-q>", "s"):run("<Esc>"),
  on("<M-q>", "i"):run("<Esc>"),
  on("<M-q>", "c"):run("<Esc>"),
  on("<M-q>", "t"):run([[<C-\><C-n>]]),

  -- easy save & quit
  lead("<Space>"):exec("w!"),
  lead(";"):exec("x"),
  lead("'"):exec("wall"),
  on("[q"):exec("q"),
  on("[Q"):exec("wqall"),

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
  on("H"):run("^"),
  on("L"):run("g_"),
  on("<C-e>", "i"):run("<C-o>A"),

  -- add line below / above current line
  on("<C-l>j", "i"):run("<C-o>o"),
  on("<C-l>k", "i"):run("<C-o>O"),

  --- window
  -- easy next window jumping
  on("<M-Tab>", "n"):run("<C-w>w"),
  -- easy split
  lead("h", "n"):exec("split"),
  lead("v", "n"):exec("vsplit"),
  on("Zh", "n"):exec("leftabove vsplit"),
  on("Zj", "n"):exec("belowright split"),
  on("Zk", "n"):exec("aboveleft split"),
  on("Zl", "n"):exec("rightbelow vsplit"),
  -- resize vertical split
  lead(".", "n"):run("<C-w>>"),
  lead(",", "n"):run("<C-w><"),
  -- resize horizontal split
  lead("=", "n"):run("<C-w>+"),
  lead("-", "n"):run("<C-w>-"),

  -- open terminal
  on("<M-`>"):exec("split term://$SHELL"),

  --- search Behaviour
  -- Map // to Search current selected text
  on("//", "v"):run('y/<c-r>"<CR>'),
  -- centering window when hit n/N
  on("n", "n"):run("mnnzz"),
  on("N", "n"):run("mnNzz"),
  -- if hlsearch is active, <CR> to clear it, otherwise <CR> is <CR>
  on("<CR>")
    :run('v:hlsearch ? "<Cmd>nohlsearch<CR>" : "<CR>"')
    :with(opt():noremap():expr()),

  -- move Line
  on("<C-j>", "n"):exec("m .+1"),
  on("<C-j>", "i"):exec("m .+1"),
  on("J", "v"):run(":m '>+1<CR>gv=gv"):with(opt():noremap():silent()),
  on("<C-k>", "n"):exec("m .-2"),
  on("<C-k>", "i"):exec("m .-2"),
  on("K", "v"):run(":m '<-2<CR>gv=gv"):with(opt():noremap():silent()),

  -- easy select-all
  on("<C-a>", "n"):run("ggVG"):with(opt():noremap():silent()),
  on("<C-a>", "i"):run("<Esc>ggVG"):with(opt():noremap():silent()),

  -- tab page
  lead("t", "n"):exec("tabnew"),
  on("<Leader>[", "n"):exec("tabprevious"),
  on("<Leader>]", "n"):exec("tabnext"),
  on("<M-[>", "n"):exec("-tabmove"),
  on("<M-]>", "n"):exec("+tabmove"),

  -- Paste-Yank behavior
  -- By default, in visual-line mode, the selected line will be yanked,
  -- and replace the previous yanked line. This map to imporve that behaviour,
  -- after paste, select the yanked line, so it's easy to yank that line again
  on("p", "v"):run("pgv"),
  -- yank-Paste from clipboard
  lead("p", "n"):run('"+p'),
  lead("p", "v"):run('"+p'),
  lead("P", "n"):run('"+P'),
  lead("P", "v"):run('"+P'),
  lead("y", "n"):run('"+y'),
  lead("y", "v"):run('"+y'),
  lead("Y", "n"):run('"+y$'),
  lead("d", "v"):run('"+d'),

  -- reselect indented line
  on("<", "v"):run("<gv"),
  on(">", "v"):run(">gv"),
  on("=", "v"):run("=gv"),
  on("<BS>", "v"):run("<gv"),
  on("<TAB>", "v"):run(">gv"),
}, {
  options = opt():noremap(),
})
