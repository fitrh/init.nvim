local M = {}

function M.setup(cmp, snippet)
  local map = cmp.mapping
  local confirm = cmp.ConfirmBehavior
  local select_only = { behavior = cmp.SelectBehavior.Select }

  local function sendkey(k)
    local key = vim.api.nvim_replace_termcodes(k, true, true, true)
    return vim.api.nvim_feedkeys(key, "n", true)
  end

  local function eol_or_space()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]
    local char = line:sub(col + 1, col + 1)
    return col == #line or char == " "
  end

  local function nop()
    return "<Nop>"
  end

  return {
    ["<Tab>"] = map({ c = nop }),
    ["<S-Tab>"] = map({ c = nop }),
    ["<C-p>"] = map({
      i = function()
        if cmp.visible() then
          cmp.select_prev_item(select_only)
        else
          cmp.complete()
        end
      end,
      c = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
          -- cmp.complete()
        else
          fallback()
          -- sendkey("<Up>")
        end
      end,
    }),
    ["<C-n>"] = map({
      i = function()
        if cmp.visible() then
          cmp.select_next_item(select_only)
        else
          cmp.complete()
        end
      end,
      c = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          -- sendkey("<Down>")
          -- if not cmp.complete() then
          fallback()
          -- end
        end
      end,
    }),
    ["<C-u>"] = map.scroll_docs(-1),
    ["<C-d>"] = map.scroll_docs(1),
    ["<C-l>"] = map.complete(),
    -- Some keys like <C-b> is better to not to return cmp function and instead
    -- continue to execute the `fallback`, by doing this, the key behavior
    -- applied along with cmp behavior e.g. <C-b> close cmp window if exist and
    -- then cursor go to left
    ["<C-b>"] = map({
      i = function(fallback)
        if cmp.visible() then
          cmp.close()
        end
        fallback()
      end,
      c = function()
        if cmp.visible() then
          cmp.close()
        end
        sendkey("<Left>")
      end,
    }),
    ["<C-f>"] = map({
      i = function(fallback)
        if cmp.visible() then
          return cmp.confirm({
            select = true,
            behavior = confirm[cmp.get_selected_entry() and "Replace" or "Insert"],
          })
        end

        if eol_or_space() then
          return cmp.complete()
        end

        fallback()
      end,
      c = function(fallback)
        -- expand if cmdline-special
        local cmdline = vim.split(vim.fn.getcmdline(), " ")
        if cmdline[#cmdline]:match("^[%%#<]") then
          sendkey(string.rep("<BS>", #cmdline[#cmdline]))
          return sendkey(vim.fn.expand(cmdline[#cmdline]))
          -- cmdline[#cmdline] = vim.fn.expand(cmdline[#cmdline])
          -- vim.fn.setcmdline(table.concat(cmdline, " "))
          -- return
        end

        if cmp.visible() then
          cmp.confirm({ select = true })
          -- vim.defer_fn(cmp.complete, 10)
          return
        end

        -- if eol_or_space() then -- FIXME: `eol_or_space` if for normal window
        --   return sendkey("<C-f>")
        -- end

        fallback()
      end,
    }),
    ["<C-e>"] = map({
      i = function(fallback)
        if cmp.visible() then
          return cmp.abort()
          -- cmp.abort()
        end

        fallback()
      end,
      c = function(fallback)
        if cmp.visible() then
          return cmp.abort()
        end

        fallback()
      end,
    }),
    ["<C-y>"] = map({
      i = function(fallback)
        if cmp.visible() then
          return cmp.confirm({ select = true })
        end

        fallback()
      end,
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end,
    }),
    -- ["<CR>"] = map.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
    ["<CR>"] = map({
      i = function(default)
        if cmp.visible() and cmp.get_selected_entry() then
          return cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
        end

        default()
      end,
      c = function(default)
        if cmp.visible() and cmp.get_selected_entry() then
          return cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
          -- return default()
        end

        -- if cmp.visible() and cmp.get_selected_entry() then
        --   return cmp.confirm()
        -- return sendkey("<CR>")
        -- return cmp.confirm()
        -- vim.defer_fn(cmp.complete, 10)
        -- return
        -- end

        default()
      end,
    }),
    ["<C-j>"] = map(function(fallback)
      -- if vim.snippet.jumpable(1) then
      --   vim.snippet.jump(1)
      if snippet.expand_or_jumpable() then
        snippet.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = map(function(fallback)
      -- FIXME: Unable to insert digraph when snippet is available
      -- REPRO: in lua, type `loc`, accept the `local function` snippet, type `
      -- if vim.snippet.jumpable(-1) then
      --   vim.snippet.jump(-1)
      if snippet.jumpable(-1) then
        snippet.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-a>"] = map({
      c = function(fallback)
        if cmp.visible() then
          cmp.close()
        end
        fallback()
      end,
    }),
    ["<Esc>"] = map({ -- Better <Esc>, close the completion window without entering `Normal` mode
      i = function(fallback)
        if cmp.visible() then
          return cmp.abort()
        end

        fallback()
      end,
      c = function()
        if cmp.visible() then
          return cmp.abort()
        end

        -- Can't use `fallback()` here because `c_Esc` from a mapping will executes the command
        -- `c_Esc` only abort the command line if it is not come from a mapping
        -- SEE: `:h c_Esc` and https://github.com/neovim/neovim/issues/11041#issuecomment-532176285
        sendkey("<C-c>")
      end,
    }),
  }
end

return M
