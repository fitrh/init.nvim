local gitsigns = require("gitsigns")

gitsigns.setup({
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '┃' },
    topdelete    = { text = '┃' },
    changedelete = { text = '┃' },
  },
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ['n ]c'] = {
      expr = true,
      "&diff ? ']c' : '<Cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"
    },
    ['n [c'] = {
      expr = true,
      "&diff ? '[c' : '<Cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"
    },

    ['n <Leader>gt'] = '<Cmd>lua require"gitsigns".toggle_signs()<CR>',
    ['n <Leader>hs'] = '<Cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <Leader>hs'] = '<Cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <Leader>hu'] = '<Cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <Leader>hr'] = '<Cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <Leader>hr'] = '<Cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <Leader>hR'] = '<Cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <Leader>hp'] = '<Cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <Leader>hb'] = '<Cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
})
