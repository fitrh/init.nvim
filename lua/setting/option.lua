local opt = vim.opt

opt.backup = false -- but do not persist backup after successful write
opt.backupcopy = "auto" -- best option for backup strategy
opt.breakindent = true
opt.colorcolumn = { "+1" } -- draw a vertical ruler at (textwidth + 1)th column
opt.complete:remove({ "u", "t" })
opt.completeopt:append({ "menuone", "noinsert" })
opt.conceallevel = 2 -- hide concealed text unless it has a custom replacement
opt.confirm = true -- raise a dialogue asking if you wish to save changed files
opt.cursorline = true -- highlight current line
opt.equalalways = true -- avoid resizing the main window when open a split
opt.expandtab = true -- by default, always use space!
opt.fillchars = { eob = " " } -- set empty line at the and of buffer to space
opt.formatoptions:append({ "n" })
opt.formatoptions:remove({ "t", "o", "2" })
opt.guicursor = "n-c:hor50,i-ci-ve:ver25"
opt.hidden = true -- enable switching unsaved buffer
opt.ignorecase = true
opt.laststatus = 0 -- disable statusline
opt.nrformats:append({ "alpha" }) -- increment/decrement for alphabet
opt.number = true
opt.pastetoggle = "<F2>" -- toggling paste mode when press this key
opt.path:append({ "**" })
opt.pumblend = 10 -- pseudo-transparency for the popup-menu, value : 0 - 100
opt.pumheight = 10 -- maximum number of items to show in the pop-up menu
opt.relativenumber = true
opt.ruler = false -- hide line & column information, use g Ctrl + g instead
opt.scrolloff = 10 -- minimal number of line to keep around the cursor
opt.shell = "/usr/bin/bash"
opt.shiftwidth = 4
opt.shortmess = {
  a = true,
  t = true,
  T = true,
  c = true,
  F = true,
}
opt.showcmd = false
opt.showmatch = true -- highlight matching <[{()}]>
opt.showmode = false
opt.showtabline = 1 -- show tab-page only if there are at least 2 tab pages
opt.sidescrolloff = 10 -- minimal number of column to keep around the cursor
opt.signcolumn = "yes"
opt.smartcase = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.synmaxcol = 120 -- do syntax highlighting until synmaxcol character
opt.termguicolors = true -- enable 24-bit RGB color in the TUI
opt.textwidth = 80 -- set 80 character as default line length
opt.undofile = true -- save undo history to an undo file on BufWrite
opt.undolevels = 100 -- maximum number of changes than can be undone
opt.updatetime = 250 -- if this many ms nothing is typed, write the swap file
opt.visualbell = true
opt.wildignore = {
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
opt.wildmode = { "longest", "full" }
opt.wildoptions:remove({ "tagfile" })
opt.wrap = false
opt.writebackup = true -- protect against crash during write
