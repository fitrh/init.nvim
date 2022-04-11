local set = vim.opt

set.backup = false -- but do not persist backup after successful write
set.backupcopy = "auto" -- best option for backup strategy
set.breakindent = true
set.colorcolumn = { "+1" } -- draw a vertical ruler at (textwidth + 1)th column
set.complete:remove({ "u", "t" })
set.completeopt:append({ "menuone", "noinsert" })
set.conceallevel = 2 -- hide concealed text unless it has a custom replacement
set.confirm = true -- raise a dialogue asking if you wish to save changed files
set.cursorline = true -- highlight current line
set.expandtab = true -- by default, always use space!
set.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
  eob = " ", -- use 'space' for lines after the last buffer line in a window
}
set.formatoptions:append({ "n" })
set.formatoptions:remove({ "t", "o", "2" })
set.guicursor = "n-c:hor50,i-ci-ve:ver25"
set.hidden = true -- enable switching unsaved buffer
set.ignorecase = true
set.laststatus = 0 -- disable statusline
set.nrformats:append({ "alpha" }) -- increment/decrement for alphabet
set.number = true
set.numberwidth = 1
set.pastetoggle = "<F2>" -- toggling paste mode when press this key
set.path:append({ "**" })
set.pumblend = 10 -- pseudo-transparency for the popup-menu, value : 0 - 100
set.pumheight = 10 -- maximum number of items to show in the pop-up menu
set.relativenumber = true
set.ruler = false -- hide line & column information, use g Ctrl + g instead
set.scrolloff = 10 -- minimal number of line to keep around the cursor
set.shell = "/usr/bin/bash"
set.shiftwidth = 4
set.shortmess = {
  a = true,
  t = true,
  T = true,
  c = true,
  F = true,
}
set.showcmd = false
set.showmatch = true -- highlight matching <[{()}]>
set.showmode = false
set.showtabline = 1 -- show tab-page only if there are at least 2 tab pages
set.sidescrolloff = 10 -- minimal number of column to keep around the cursor
set.signcolumn = "yes"
set.smartcase = true
set.softtabstop = 4
set.splitbelow = true
set.splitright = true
set.synmaxcol = 120 -- do syntax highlighting until synmaxcol character
set.termguicolors = true -- enable 24-bit RGB color in the TUI
set.textwidth = 80 -- set 80 character as default line length
set.undofile = true -- save undo history to an undo file on BufWrite
set.undolevels = 100 -- maximum number of changes than can be undone
set.updatetime = 250 -- if this many ms nothing is typed, write the swap file
set.visualbell = true
set.wildignore = {
  "*.o",
  "*.obj",
  "*.a",
  "*.so",
  "*.out",
  "*.class",
  "*.pyc",
  "*.jpg",
  "*.jpeg",
  "*.png",
  "*.gif",
  "*.tiff",
  "*.webp",
  "*.pdf",
  "*.odt",
  "*.odp",
  "*.doc",
  "*.docx",
  "*.ppt",
  "*.csv",
  "__pycache__",
  "*pycache*",
  "**/tmp/**",
  "**/node_modules/**",
  ".git",
}
set.wildmode = { "longest", "full" }
set.wildoptions:remove({ "tagfile" })
set.wrap = false
set.writebackup = true -- protect against crash during write
