local State = {}

State.modified = {
  function()
    return ""
  end,
  cond = function()
    return vim.api.nvim_buf_get_option(0, "modified")
  end,
  color = "StatusLineModified",
}

State.readonly = {
  function()
    return ""
  end,
  cond = function()
    local opt = vim.api.nvim_buf_get_option
    local not_terminal = opt(0, "buftype") ~= "terminal"
    local readonly = opt(0, "readonly")
    local modifiable = opt(0, "modifiable")
    return (readonly or not modifiable) and not_terminal
  end,
  color = "StatusLineRO",
}

return State
