local set = vim.opt

set.backup = true -- always persist backup file
set.backupcopy = "auto" -- best option for backup strategy
set.backupdir = ("%s/backup//"):format(vim.fn.stdpath("state"))
set.backupskip:append({ "*/.git/*", "*.gpg" }) -- file patterns to ignore by 'backup'
set.breakindent = true -- continue indenting wrapped lines
set.cmdheight = 0 -- disable command-line when not being used
set.complete:remove({ -- disable scan for
  "u", -- unload buffers
  "t", -- tag completion
})
set.completeopt:append({
  "menuone", -- use the popup menu also when there is only one match
  "noinsert", -- do not insert any text for a match until the user selects a match from the menu
  "noselect", -- do not select a match in the menu, force the user to select one from the menu
})
set.conceallevel = 2 -- hide concealed text unless it has a custom replacement
set.confirm = true -- raise a dialogue asking if you wish to save changed files
set.cursorline = true -- highlight current line
set.diffopt:append({
  "linematch:60", -- enable a second stage diff on each generated hunk in order to align lines
})
set.fillchars = {
  foldopen = "",
  foldclose = "",
  diff = "/",
  eob = " ", -- use 'space' for lines after the last buffer line in a window
}
set.guicursor = "n-c:hor50,i-ci-ve:ver25" -- horizontal in normal, vertical in insert
set.hidden = true -- enable switching unsaved buffer
set.ignorecase = true -- use case-insensitive in search
set.laststatus = 3 -- use global status line
set.mouse = "" -- ignore mouse completely
set.nrformats:append({ "alpha" }) -- increment/decrement for alphabet
set.number = true -- enable line number
set.pastetoggle = "<F2>" -- toggling paste mode when press this key
set.path:remove({ "/usr/include" }) -- remove system header from search commands
set.path:append({ "**" }) -- search in current directory recursively
set.pumblend = 10 -- pseudo-transparency for the popup-menu, value : 0 - 100
set.relativenumber = true -- show line number relative to the line with the cursor
set.ruler = false -- hide line & column information, use g Ctrl + g instead
set.shell = "/bin/sh" -- use absolute path to avoid using $SHELL
set.shiftwidth = 0 -- number of spaces to use for each step of (auto)indent, 0 means use 'tabstop' value
set.shortmess = { -- shorten message in prompt window
  a = true, -- enable 'filmnrwx' flag
  o = true, -- overwrite message for writing a file with subsequent message for reading a file
  t = true, -- truncate file message at the start
  s = true, -- don't give "search hit/continuing *" message
  T = true, -- truncate other messages in the middle
  W = true, -- don't give "written" or "[w]" when writing a file
  I = true, -- don't give the intro message when starting Vim
  c = true, -- don't give ins-completion-menu messages
  C = true, -- don't give messages while scanning for ins-completion items
  F = true, -- don't give the file info when editing a file
  S = true, -- don't show search count message when searching
}
set.showcmd = false -- hide (partial) command in the last line of the screen
set.showmatch = true -- highlight matching <[{()}]>
set.showmode = false -- hide current mode in command-line window
set.showtabline = 1 -- show tab-page only if there are at least 2 tab pages
set.signcolumn = "no" -- disable signcolumn
set.smartcase = true -- use case-sensitive when the search term contains an uppercase letter
set.softtabstop = -1 -- number of spaces that a <Tab> counts for while performing editing operations, negative means use 'shiftwidth' value
set.splitbelow = true -- when :split, put the new window below the current one
set.splitkeep = "topline" -- when resizing or splitting a window, keep the top line the same
set.splitright = true -- when :vsplit, put the new window right of the current one
set.statusline = " %(%r %)%{%&bt==''?&ft==''?'%f':'%f %LL %m%=%l,%-2c':''%} "
set.synmaxcol = 120 -- do syntax highlighting until synmaxcol character
set.termguicolors = true -- enable 24-bit RGB color in the TUI
set.textwidth = 80 -- set 80 character as default line length
set.undofile = true -- save undo history to an undo file on BufWrite
set.undolevels = 100 -- maximum number of changes than can be undone
set.updatetime = 500 -- if this many ms nothing is typed, write the swap file
set.visualbell = true
set.wildignore = { -- list of file patterns to ignore when expanding wildcards
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
set.wrap = false -- disable line wrap
set.writebackup = true -- protect against crash during write
