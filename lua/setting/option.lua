local opt = vim.opt

opt.shell = "/usr/bin/bash"
opt.pastetoggle = "<F2>" -- toggling paste mode when press this key
opt.hidden = true -- enable switching unsaved buffer
opt.wrap = false
opt.showcmd = false
opt.showmode = false
opt.laststatus = 0 -- disable statusline
opt.ruler = false -- hide line & column information, use g Ctrl + g instead
opt.writebackup = true -- protect against crash during write
opt.backup = false -- but do not persist backup after successful write
opt.backupcopy = "auto" -- best option for backup strategy
opt.nrformats:append({ "alpha" }) -- increment/decrement for alphabet
opt.path:append({ "**" })
opt.shortmess = {
  a = true,
  t = true,
  T = true,
  c = true,
  F = true,
}
opt.showtabline = 1 -- show tab-page only if there are at least 2 tab pages
opt.synmaxcol = 120 -- do syntax highlighting until synmaxcol character
opt.undofile = true -- save undo history to an undo file on BufWrite
opt.undolevels = 100 -- maximum number of changes than can be undone
opt.updatetime = 250 -- if this many ms nothing is typed, write the swap file
opt.conceallevel = 2 -- hide concealed text unless it has a custom replacement

-- Scroll offset, minimal number of line or column to keep around the cursor
opt.scrolloff = 10
opt.sidescrolloff = 10

--- popup-menu
--[[
  Maximum number of items to show in the pop-up menu.
  Zero means 'use available screen space'.
--]]
opt.pumheight = 10
opt.pumblend = 10 -- pseudo-transparency for the popup-menu, value : 0 - 100

-- Line Number
opt.number = true
opt.relativenumber = true
--[[
  put extra space before line number for display some symbol e.g. linter report,
  so the line number would not shift each time the symbol appear.
--]]
opt.signcolumn = "yes"

-- set empty line at the and of buffer to space, default: ~
opt.fillchars = { eob = " " }

--[[
  split Behaviour, by default, split will open new window on the left or above
  the current window. This opt will make split behavior to open new window on
  the right or below the current window.
--]]
opt.splitright = true
opt.splitbelow = true

opt.equalalways = true -- avoid resizing the main window when open a split

-- Space and Tab
opt.expandtab = true -- By default, always use space!
opt.shiftwidth = 4
opt.softtabstop = 4

-- Indentation
opt.breakindent = true

-- Use case insensitive search, except when using capital letters
opt.ignorecase = true
opt.smartcase = true

-- Raise a dialogue asking if you wish to save changed files.
opt.confirm = true

-- Use visual bell instead of beeping when doing something wrong.
opt.visualbell = true

opt.termguicolors = true -- enable 24-bit RGB color in the TUI

-- Disable mouse
opt.mouse = ""

-- line length
opt.textwidth = 80 -- set 80 character as default line length
-- draw a vertical ruler at 81th or (textwidth + 1) character
opt.colorcolumn = { "+1" }

-- Cursor Line
opt.cursorline = true -- highlight current line
opt.guicursor = "n-c:hor50,i-ci-ve:ver25"
opt.showmatch = true -- highlight matching <[{()}]>

-- ignored wildcard
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

--- autoformat option
-- see :help fo-table
opt.formatoptions:append({ "n" })
opt.formatoptions:remove({ "t", "o", "2" })

-- completion
opt.complete:remove({ "u", "t" })
opt.completeopt:append({ "menuone", "noinsert" })
opt.wildmode = { "longest", "full" }
opt.wildoptions:remove({ "tagfile" })
