-- vi: set foldmethod=marker:

-- Syntactic sugar {{{
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  if type(rhs) == "function" then
    opts.callback = rhs
    rhs = ""
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

local function nmap(...)
  map("n", ...)
end
local function imap(...)
  map("i", ...)
end
local cmd = vim.cmd
-- }}}

-- TODO: h,j,k,l on the edge move to the next window
-- TODO: [count]<C-w>m to move window using win_splitmove
-- TODO: [count]<C-w>gx to exchange window using nvim_win_set_buf, fn.win_getid
-- SEE: https://github.com/andymass/vim-tradewinds

-- Disable arrow and page keys {{{
-- TODO: also disable the shift/control variants, e.g <S-Left>, <C-Right>
for _, key in ipairs({ "Up", "Down", "Left", "Right", "PageUp", "PageDown" }) do
  for _, m in ipairs({ "", "i", "c", "l", "!", "t" }) do
    map(m, "<" .. key .. ">", "", { noremap = true })
  end
end
-- }}}

-- Set undo-break for these characters {{{
for _, key in ipairs({ " ", "@", ".", ",", ":", ";", "-", "_", "=" }) do
  imap(key, key .. "<C-g>u", { silent = true, noremap = true })
end
-- }}}

-- Cursor movements {{{
-- imap("<C-e>", function() -- cursor to the end of line
--   local row, col = unpack(vim.api.nvim_win_get_cursor(0))
--   local rowstr = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]
--
--   if rowstr:sub(col + 1, col + 1) == "" then -- EOL
--     return "<Down><Home>" -- Move down and go to start of line
--   end
--
--   return "<End>"
-- end, { expr = true, noremap = true })
--
-- imap("<C-a>", function() -- cursor to the start of line
--   local _, col = unpack(vim.api.nvim_win_get_cursor(0))
--   if col == 0 then -- On the start of line
--     return "<Up><End>" -- Move up and go to EOL
--   end
--
--   return "<Home>"
-- end, { expr = true, noremap = true })
-- }}}

-- Return to search starting point {{{
-- Prevents changing the jumlist on n/N so that we can return to the starting
-- point with CTRL-O
-- TODO: Revisit alternative approach of remapping each search keys to ms<key>,
-- this approach doesn't change the n/N behavior (which is useful), and maybe
-- remap <Esc> go back to s mark (`s) —the start starting point— when v:hlsearch
-- is set
nmap("n", "<Cmd>keepjumps normal! n<CR>", { noremap = true })
nmap("N", "<Cmd>keepjumps normal! N<CR>", { noremap = true })
-- }}}

-- Yank-Comment-Paste {{{
nmap("yc", function() -- downward
  local c = vim.api.nvim_get_vvar("count")
  local k = c > 0 and "y" .. c .. "jgc" .. c .. "j']p" or "yygccp"
  vim.api.nvim_feedkeys(k, "m", true)
end, { nowait = true })
nmap("yC", function() -- upward
  local c = vim.api.nvim_get_vvar("count")
  local k = c > 0 and "y" .. c .. "kgc" .. c .. "j'[P" or "yygccP"
  vim.api.nvim_feedkeys(k, "m", true)
end, { nowait = true })
-- }}}

-- EZ write {{{
nmap("<Leader><Space>", function()
  if not vim.api.nvim_get_option_value("modified", { buf = 0 }) then
    return
  end

  if vim.api.nvim_buf_get_name(0) == "" then
    vim.ui.input({ prompt = " Bufname: " }, function(input)
      if input and input ~= "" then
        vim.cmd("silent write ++p " .. input)
      end
    end)
    return
  end

  -- TODO: Express `++p` with `nvim_cmd({ cmd = 'write' }, {})`
  -- SEE: https://github.com/neovim/neovim/pull/30103
  vim.cmd("silent write ++p")
end)
-- }}}

-- EZ quit {{{
nmap("zZ", cmd.xall)
nmap("zQ", cmd.qall)
nmap("ZQ", function()
  cmd.qall({ bang = true })
end)
-- }}}

-- Misc {{{
nmap("zS", vim.show_pos)
nmap("zK", "K") -- keywordprg, since K get mapped to LSP Hover on `LspAttach`
-- Insert timestamp
imap("<C-g>t", "<C-r>=strftime('%FT%T%z')<CR>", { silent = true })
imap("<C-g>T", function()
  local ts = os.date("%FT%T%z")
  local tw = vim.api.nvim_get_option_value("textwidth", { buf = 0 })
  vim.api.nvim_paste(ts .. string.rep(".", tw - #ts), false, -1)
end)
-- }}}

-- Experimental {{{
-- setmap("ca", "f", "find **", { noremap = true })
-- TODO: excludes buffer change on specific buftype/filetype, e.g. ft=help
-- setmap("n", "<C-[>", "", {
--   callback = function()
--     local alt_fname = vim.fn.expand("#")
--     if alt_fname == "" or alt_fname == vim.fn.expand("%") then
--       local default = vim.api.nvim_replace_termcodes("<C-[>", true, false, true)
--       vim.api.nvim_feedkeys(default, "n", false)
--       return
--     end
--     -- vim.cmd.edit("#")
--     vim.api.nvim_cmd({ cmd = "edit", args = { "#" } }, { output = false })
--   end,
--   silent = true,
--   noremap = true,
-- })
-- }}}
