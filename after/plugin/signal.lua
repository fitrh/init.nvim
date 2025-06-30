-- TODO: React on `TermResponse` event

-- Use `Signal SIGUSR1` to change `'background'` at runtime
-- NOTE triggered with `pkill -USR1 nvim`
vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  group = vim.api.nvim_create_augroup("toggle_bg_on_SIGUSR1", {}),
  callback = function()
    -- local state = io.open(os.getenv("XDG_STATE_HOME") .. "/appear")
    -- local state_v = state and state:read()
    -- if state then
    --   state:close()
    -- end

    local option = "background"
    local dark = vim.api.nvim_get_option_value(option, {}) == "dark"
    vim.api.nvim_set_option_value(option, dark and "light" or "dark", {})
    vim.schedule(function()
      -- without this, nvim window need to be focused for the effect take into account
      -- vim.cmd("redraw!")
      vim.cmd.redraw({ bang = true })
    end)
  end,
  nested = true, -- allow this autocmd to trigger `OptionSet background` event
})
