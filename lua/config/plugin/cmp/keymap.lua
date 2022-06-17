local M = {}

function M.setup(cmp, snippet)
  local map = cmp.mapping
  local select_only = { behavior = cmp.SelectBehavior.Select }

  return {
    ["<C-p>"] = map({
      i = map.select_prev_item(select_only),
      c = map.select_prev_item(),
    }),
    ["<C-n>"] = map({
      i = map.select_next_item(select_only),
      c = map.select_next_item(),
    }),
    ["<C-b>"] = map.scroll_docs(-4),
    ["<C-f>"] = map.scroll_docs(4),
    ["<C-l>"] = map.complete(),
    ["<C-e>"] = map(map.abort(), { "i", "c" }),
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
