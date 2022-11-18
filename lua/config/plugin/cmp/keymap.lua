local M = {}

function M.setup(cmp, snippet)
  local map = cmp.mapping
  local select_only = { behavior = cmp.SelectBehavior.Select }
  local function termcode(key)
    return vim.api.nvim_replace_termcodes(key, true, true, true)
  end

  return {
    ["<C-p>"] = map({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item(select_only)
        else
          fallback()
        end
      end,
      c = function()
        if cmp.visible() then
          cmp.select_prev_item()
        else
          vim.api.nvim_feedkeys(termcode("<Up>"), "n", true)
        end
      end,
    }),
    ["<C-n>"] = map({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item(select_only)
        else
          fallback()
        end
      end,
      c = function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          vim.api.nvim_feedkeys(termcode("<Down>"), "n", true)
        end
      end,
    }),
    ["<C-u>"] = map.scroll_docs(-4),
    ["<C-d>"] = map.scroll_docs(4),
    ["<C-l>"] = map.complete(),
    ["<C-b>"] = map(map.abort(), { "i", "c" }),
    ["<C-f>"] = map(map.confirm({ select = true }), { "i", "c" }),
    ["<C-e>"] = map(map.abort(), { "i", "c" }),
    ["<C-y>"] = map({
      i = map.confirm({ select = true }),
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end,
    }),
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
