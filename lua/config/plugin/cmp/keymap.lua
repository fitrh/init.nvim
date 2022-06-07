local M = {}

function M.setup(cmp, snippet)
  local map = cmp.mapping

  return {
    ["<C-p>"] = map(map.select_prev_item(), { "i", "c" }),
    ["<C-n>"] = map(map.select_next_item(), { "i", "c" }),
    ["<C-b>"] = map.scroll_docs(-4),
    ["<C-f>"] = map.scroll_docs(4),
    ["<C-l>"] = map.complete(),
    ["<C-e>"] = map.abort(),
    ["<C-y>"] = map.confirm({ select = true }),
    ["<CR>"] = map.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
    ["<C-j>"] = map(function(fallback)
      if snippet.expand_or_jumpable() then
        snippet.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = map(function(fallback)
      if snippet.jumpable(-1) then
        snippet.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }
end

return M
