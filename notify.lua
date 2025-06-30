for k, v in pairs(vim.log.levels) do
  vim.notify(string.format("[%d] %-5s: Notification message...", v, k), v, {})
  vim.wait(500, function() end)
end
