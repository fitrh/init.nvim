local M = {}

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match("%s")
      == nil
end

function M.setup(cmp, snippet)
  local map = cmp.mapping

  return {
    ["<C-p>"] = map(map.select_prev_item(), { "i", "c" }),
    ["<C-n>"] = map(map.select_next_item(), { "i", "c" }),
    ["<C-b>"] = map.scroll_docs(-4),
    ["<C-f>"] = map.scroll_docs(4),
    ["<C-Space>"] = map.complete(),
    ["<C-e>"] = map.abort(),
    ["<C-y>"] = map.confirm({ select = true }),
    ["<CR>"] = map.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
    ["<Tab>"] = map(function(fallback)
      if snippet.expand_or_jumpable() then
        snippet.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = map(function(fallback)
      if snippet.jumpable(-1) then
        snippet.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }
end

return M
