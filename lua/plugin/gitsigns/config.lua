local gitsigns = require("gitsigns")

gitsigns.setup({
  signs = {
    add          = { text = "┃" },
    change       = { text = "┃" },
    delete       = { text = "┃" },
    topdelete    = { text = "┃" },
    changedelete = { text = "┃" },
  },
  current_line_blame = true,
  current_line_blame_delay = 300, -- in ms
  keymaps = {}, -- disable default keymap
  on_attach = function(bufnr)
    local keymap = require("plugin.gitsigns.keymap")
    keymap.on_attach(bufnr)
  end
})

    ['n ]c'] = {
      expr = true,
      "&diff ? ']c' : '<Cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"
    },
    ['n [c'] = {
      expr = true,
      "&diff ? '[c' : '<Cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"
    },

    ['n gt'] = '<Cmd>lua require"gitsigns".toggle_signs()<CR>',
    ['n ghs'] = '<Cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v ghs'] = '<Cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n ghu'] = '<Cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n ghr'] = '<Cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v ghr'] = '<Cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n ghR'] = '<Cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n ghp'] = '<Cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n gbl'] = '<Cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <Leader>gl'] = '<Cmd>lua require"gitsigns".toggle_current_line_blame()<CR>',

    -- Text objects
    ['o ih'] = '<Cmd>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = '<Cmd>lua require"gitsigns.actions".select_hunk()<CR>'
  },
})
