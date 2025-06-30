local Keymap = {}

-- n.xi(function() end)
-- n['<Leader>j'](function() end)
-- map.gf(function()
--   require("telescope.builtin").find_files()
-- end)

function Keymap.map(key, action, kwargs)
  kwargs = kwargs or {}

  local opts = {
    nowait = kwargs.nowait,
    silent = kwargs.silent,
    script = kwargs.script,
    expr = kwargs.expr,
    unique = kwargs.unique,
    desc = kwargs.desc or "",
    noremap = kwargs.noremap,
  }

  local mode = kwargs.mode or ""
  local rhs = action
  if type(action) == "function" then
    rhs = ""
    opts.callback = action
  end

  if opts.silent == nil then
    opts.silent = true
  end
  if opts.noremap == nil then
    opts.noremap = true
  end

  if kwargs.buf then
    vim.api.nvim_buf_set_keymap(kwargs.buf, mode, key, rhs, opts)
    return
  end

  vim.api.nvim_set_keymap(mode, key, rhs, opts)
end

return Keymap
