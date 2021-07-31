local keymap = require("util.keymap")
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

  -- FIXME: disable mouse wheele
  -- on("<ScrollWheelUp>", "n"):disable(),
  -- on("<S-ScrollWheelUp>", "n"):disable(),
  -- on("<ScrollWheelDown>", "n"):disable(),
  -- on("<S-ScrollWheelDown>", "n"):disable(),

  -- easy escape
  on("<A-q>"):run("<Esc>"):with(opt():noremap()),
  on("<A-q>", "s"):run("<Esc>"):with(opt():noremap()),
  on("<A-q>", "i"):run("<Esc>"):with(opt():noremap()),
  on("<A-q>", "c"):run("<Esc>"):with(opt():noremap()),
  on("<A-q>", "t"):run([[<C-\><C-n>]]):with(opt():noremap()),

  -- easy save & quit
  lead("<Space>"):exec("w!"):with(opt():noremap()),
  lead(";"):exec("wq"):with(opt():noremap()),
  lead("'"):exec("wall"):with(opt():noremap()),
  lead("qq"):exec("q"):with(opt():noremap()),
  lead("ql"):exec("wqall"):with(opt():noremap()),
  lead("x"):exec("x"):with(opt():noremap()),

  --- buffer
  -- next & previous buffer
  on("<S-Tab>", "n"):exec("bprevious"):with(opt():noremap()),
  on("<Tab>", "n"):exec("bnext"):with(opt():noremap()),
  -- close buffer without close window
  lead("qb", "n"):exec("enew <BAR> bdelete #"):with(opt():noremap()),
  -- delete current buffer and move to the previous buffer
  lead("bd", "n"):exec("bprevious <BAR> bdelete #"):with(opt():noremap()),

  -- toggle cursorline or cursorcolumn
  on("<C-c>c", "n"):exec("set cursorcolumn!"):with(opt():noremap()),
  on("<C-c>l", "n"):exec("set cursorline!"):with(opt():noremap()),

  -- toggle number
  lead("nn"):exec("set relativenumber!"):with(opt():noremap()),
  lead("ln"):exec("set number!"):with(opt():noremap()),
  lead("zz"):lua(
    'require("util.keymap.toggle").zen({ laststatus = true })'
  ):with(opt():noremap()),
  lead("nr"):lua('require("util.keymap.toggle").zen()'):with(opt():noremap()),

  -- cursor movements
  on("H"):run("^"):with(opt():noremap()),
  on("L"):run("g_"):with(opt():noremap()),
  on("<C-e>", "i"):run("<C-o>A"):with(opt():noremap()),

  -- add line below / above current line
  on("<C-l>j", "i"):run("<C-o>o"):with(opt():noremap()),
  on("<C-l>k", "i"):run("<C-o>O"):with(opt():noremap()),

  --- window
  -- easy split
  lead("h", "n"):exec("split"):with(opt():noremap()),
  lead("v", "n"):exec("vsplit"):with(opt():noremap()),
  on("Zh", "n"):exec("leftabove vsplit"):with(opt():noremap()),
  on("Zj", "n"):exec("belowright split"):with(opt():noremap()),
  on("Zk", "n"):exec("aboveleft split"):with(opt():noremap()),
  on("Zl", "n"):exec("rightbelow vsplit"):with(opt():noremap()),
  -- resize vertical split
  lead(".", "n"):run("<C-w>>"):with(opt():noremap()),
  lead(",", "n"):run("<C-w><"):with(opt():noremap()),
  -- resize horizontal split
  lead("=", "n"):run("<C-w>+"):with(opt():noremap()),
  lead("-", "n"):run("<C-w>-"):with(opt():noremap()),

  -- open terminal
  on("<A-`>"):exec("split term://$SHELL"):with(opt():noremap()),

  --- search Behaviour
  -- Map // to Search current selected text
  on("//", "v"):run('y/<c-r>"<CR>'):with(opt():noremap()),
  -- centering window when hit n/N
  on("n", "n"):run("mnnzz"):with(opt():noremap()),
  on("N", "n"):run("mnNzz"):with(opt():noremap()),
  -- if hlsearch is active, <CR> to clear it, otherwise <CR> is <CR>
  on("<CR>"):run(
    'v:hlsearch ? "<Cmd>nohlsearch<CR>" : "<CR>"'
  ):with(opt():noremap():expr()),

  -- move Line
  on("<C-j>", "n"):exec("m .+1"):with(opt():noremap()),
  on("<C-j>", "i"):exec("m .+1"):with(opt():noremap()),
  on("J", "v"):run(":m '>+1<CR>gv=gv"):with(opt():noremap():silent()),
  on("<C-k>", "n"):exec("m .-2"):with(opt():noremap()),
  on("<C-k>", "i"):exec("m .-2"):with(opt():noremap()),
  on("K", "v"):run(":m '<-2<CR>gv=gv"):with(opt():noremap():silent()),

  -- easy select-all
  on("<C-a>", "n"):run("ggVG"):with(opt():noremap():silent()),
  on("<C-a>", "i"):run("<Esc>ggVG"):with(opt():noremap():silent()),

  -- tab page
  lead("t", "n"):exec("tabnew"):with(opt():noremap()),
  on("<Leader>[", "n"):exec("tabprevious"):with(opt():noremap()),
  on("<Leader>]", "n"):exec("tabnext"):with(opt():noremap()),
  on("<M-[>", "n"):exec("-tabmove"):with(opt():noremap()),
  on("<M-]>", "n"):exec("+tabmove"):with(opt():noremap()),


  -- Paste-Yank behavior
  -- By default, in visual-line mode, the selected line will be yanked,
  -- so it's replace the previous yanked line.
  -- This map to prevent that behaviour, after paste, select all the yanked line,
  -- and yank again
  on("p", "v"):run("pgvy"):with(opt():noremap()),
  -- on("y", "v"):exec("ygv"):with(opt():noremap()),
  -- yank current line
  on("Y", "n"):run("yy"):with(opt():noremap()),
  -- yank-Paste from clipboard
  lead("p", "n"):run('"+p'):with(opt():noremap()),
  lead("p", "v"):run('"+p'):with(opt():noremap()),
  lead("P", "n"):run('"+P'):with(opt():noremap()),
  lead("P", "v"):run('"+P'):with(opt():noremap()),
  lead("y", "n"):run('"+y'):with(opt():noremap()),
  lead("y", "v"):run('"+y'):with(opt():noremap()),
  lead("Y", "n"):run('"+y$'):with(opt():noremap()),
  lead("d", "v"):run('"+d'):with(opt():noremap()),

  -- reselect indented line
  on("<", "v"):run("<gv"):with(opt():noremap()),
  on(">", "v"):run(">gv"):with(opt():noremap()),
  on("=", "v"):run("=gv"):with(opt():noremap()),
  on("<BS>", "v"):run("<gv"):with(opt():noremap()),
  on("<TAB>", "v"):run("<gv"):with(opt():noremap()),
})
