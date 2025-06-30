-- vi: set foldmethod=marker:
-- set foldmethod=expr foldexpr='v:lua.vim.treesitter.foldexpr()':

-- Syntactic sugar {{{
local a = vim.api
local filter_t = { number = "buffer", string = "pattern", table = "pattern" }
local action_t = { string = "command", ["function"] = "callback" }

---@alias AutocmdFn string|fun(ctx: vim.api.keyset.create_autocmd.callback_args): boolean?
---@alias Event string|string[]
---@alias Filter number|string|string[]|AutocmdFn
---@alias CreateAutocmd fun(event: Event, filter: Filter, action?: AutocmdFn, opts?: vim.api.keyset.create_autocmd)

---@param name string
---@param augopts vim.api.keyset.create_augroup|fun(cb: CreateAutocmd)
---@param autocmd? fun(cb: CreateAutocmd)
local function augroup(name, augopts, autocmd)
  if type(augopts) == "function" and not autocmd then
    autocmd = augopts
    augopts = { clear = true }
  end

  local group = a.nvim_create_augroup("fitrh." .. name, augopts)
  autocmd(function(events, filter, action, opts)
    if type(filter) == "function" then
      opts = action or {}
      action = filter
      filter = "*"
    end

    opts = opts or {}
    opts.group = group
    opts[filter_t[type(filter)]] = filter
    opts[action_t[type(action)]] = action
    -- TODO: Call nvim_clear_autocmds?
    a.nvim_create_autocmd(events, opts)
  end)
end
-- }}}

-- TODO: on BufWinEnter, if not `'modifiable'`, map editing keys to navigating
--       keys/behaviors (e.g. u -> <C-u>, d -> <C-d>, o -> gO)
-- TODO: on CmdlineEnter, add \%V atom when in char-wise visual mode
-- TODO: on VimResized, set wrap if window width < textwidth
-- TODO: Set `'previewheight'` dynamically, see adaptive_{scrolloff,pumheight} augroup

-- augroup("test", function(autocmd)
--   autocmd("ModeChanged", function(ctx)
--     local m = vim.api.nvim_get_mode().mode
--     if m:match("[irR]") then
--       vim.notify("INSERT " .. m)
--       return
--     end
--
--     if m:match("[vVsS\x16\x13]") then
--       vim.notify("VISUAL " .. m)
--       return
--     end
--   end)
-- end)

augroup("config_dir", function(autocmd) -- {{{
  -- TODO: Use `vim.fn.stdpath('config')` as pattern
  autocmd("BufWinEnter", "*/.config/nvim/*", function(ctx)
    vim.api.nvim_set_option_value("keywordprg", ":help", { buf = ctx.buf })
    vim.api.nvim_buf_set_keymap(ctx.buf, "n", "<C-w>gh", "", {
      desc = "Open help page for <cword>",
      callback = function()
        local cword = vim.fn.expand("<cword>")
        vim.cmd.help(cword)
      end,
    })
  end)
end) -- }}}

augroup("fugitive", function(autocmd) -- {{{
  autocmd("User", "Fugitive*", function(ctx)
    a.nvim_buf_set_keymap(ctx.buf, "n", "q", "<Cmd>close<CR>", {
      noremap = true,
      silent = true,
      nowait = true,
    })
  end)
end) -- }}}

augroup("equals_on_resize", function(autocmd) -- {{{
  autocmd("VimResized", function()
    vim.cmd.wincmd("=")
  end)
end) -- }}}

augroup("ghost_linenr", function(autocmd) -- {{{
  autocmd("InsertEnter", function(ctx)
    local o = { buf = ctx.buf }
    local bt = vim.api.nvim_get_option_value("buftype", o)
    if
      not (bt == "" and vim.api.nvim_get_option_value("buflisted", o))
      and bt ~= "quickfix"
      and bt ~= "help"
    then
      return
    end

    -- local ns = vim.api.nvim_create_namespace("GhostNr")
    -- vim.api.nvim_set_hl(ns, "LineNr", { link = "GhostLineNr" })
    -- vim.api.nvim_set_hl(ns, "CursorLineNr", { link = "GhostLineNr" })
    vim.schedule(function()
      -- FIXME: `nvim_win_set_hl_ns` conflict with modes.nvim
      -- vim.api.nvim_win_set_hl_ns(0, ns)
      local whl = vim.wo.winhighlight
      vim.wo.winhighlight = whl
        .. (string.find(whl, "%w+:%w+") and "," or "")
        .. "LineNr:GhostLineNr,CursorLineNr:GhostLineNr"
    end)
  end)

  autocmd("InsertLeave", function(ctx)
    local o = { buf = ctx.buf }
    local bt = vim.api.nvim_get_option_value("buftype", o)
    if
      not (bt == "" and vim.api.nvim_get_option_value("buflisted", o))
      -- and buftype ~= "quickfix"
      -- and buftype ~= "help"
    then
      return
    end

    vim.schedule(function()
      -- vim.api.nvim_win_set_hl_ns(0, 0)
      local whl = vim.wo.winhighlight
      if whl:match("GhostLineNr") then
        vim.wo.winhighlight = whl
          :gsub("LineNr:GhostLineNr,?", "")
          :gsub("CursorLineNr:GhostLineNr,?", "")
      end
    end)
  end)
end) -- }}}

augroup("nohlsearch_in_insert", function(autocmd) -- {{{
  autocmd("InsertEnter", function()
    if vim.api.nvim_get_vvar("hlsearch") == 1 then
      vim.schedule(function()
        vim.api.nvim_set_vvar("hlsearch", false)
        vim.cmd.redrawstatus()
      end)
    end
  end)
end) -- }}}

augroup("nornu_on_cmdline", function(autocmd) -- {{{
  autocmd("CmdlineEnter", function()
    local wo = { scope = "local", win = 0 }
    if
      vim.api.nvim_get_option_value("number", wo)
      and vim.api.nvim_get_option_value("relativenumber", wo)
    then
      vim.api.nvim_set_option_value("relativenumber", false, wo)
      vim.cmd.redraw()
    end
  end)

  autocmd("CmdlineLeave", function()
    local wo = { scope = "local", win = 0 }
    if
      vim.api.nvim_get_option_value("number", wo)
      and not vim.api.nvim_get_option_value("relativenumber", wo)
    then
      vim.api.nvim_set_option_value("relativenumber", true, wo)
    end
  end)
end) -- }}}

augroup("set_line_number", function(autocmd) -- {{{
  local set = vim.api.nvim_set_option_value
  local get = vim.api.nvim_get_option_value
  autocmd("BufWinEnter", function(ctx)
    local o = { buf = ctx.buf }

    local bt = get("buftype", o)
    if not (bt == "" and get("buflisted", o)) and bt ~= "quickfix" then
      return
    end

    local wo = { scope = "local", win = 0 }
    if vim.api.nvim_buf_get_name(o.buf) == "" and get("filetype", o) == "" then
      set("number", false, wo)
      set("relativenumber", false, wo)
      return
    end

    set("number", true, wo)
    set("relativenumber", true, wo)
  end)

  autocmd("BufWritePost", function()
    for _, option in ipairs({ "number", "relativenumber" }) do
      if not get(option, { scope = "local", win = 0 }) then
        set(option, true, { scope = "local", win = 0 })
      end
    end
  end)
end) -- }}}

augroup("set_hl-MsgArea", function(autocmd) -- {{{
  -- FIXME: Lack of contrast when starting with file (e.g. vi file.txt)
  autocmd("ColorScheme", function()
    local cmdheight = vim.api.nvim_get_option_value("cmdheight", {})
    local link = cmdheight == 0 and "StatusLine" or "Normal"
    vim.api.nvim_set_hl(0, "MsgArea", { link = link })
  end)

  autocmd("OptionSet", "cmdheight", function()
    local new_val = vim.api.nvim_get_vvar("option_new")
    local link = new_val == 0 and "StatusLine" or "Normal"
    vim.api.nvim_set_hl(0, "MsgArea", { link = link })
  end)
end) -- }}}

augroup("set_hl-WinSeparator", function(autocmd) -- {{{
  autocmd("WinNew", function()
    local laststatus = vim.api.nvim_get_option_value("laststatus", {})
    local group = "WinSeparator"
    local def = vim.api.nvim_get_hl(0, { name = group, link = false })
    def = { fg = def.fg, bg = laststatus ~= 3 and def.fg or "NONE" }

    vim.api.nvim_set_hl(0, group, def)
    return true
  end)

  autocmd("OptionSet", "laststatus", function()
    local v = vim.api.nvim_get_vvar
    if v("option_new") == v("option_old") then
      return
    end

    local group = "WinSeparator"
    local def = vim.api.nvim_get_hl(0, { name = group, link = false })
    def = { fg = def.fg, bg = v("option_new") ~= 3 and def.fg or "NONE" }
    -- if v("option_new") == 3 then
    --   def = { fg = def.fg }
    -- else
    --   def.bg = def.fg
    -- end

    vim.api.nvim_set_hl(0, group, def)
  end)
end) -- }}}

-- TODO: Move it to after/plugin/statuscolumn.lua
augroup("set_statuscolumn", function(autocmd) -- {{{
  local stc = [[%{%v:lua.require'config.option.statuscolumn'()%}]]

  autocmd("UIEnter", function(ctx)
    local bo = { buf = ctx.buf }
    local bt = vim.api.nvim_get_option_value("buftype", bo)
    local ft = vim.api.nvim_get_option_value("filetype", bo)
    if
      not (bt == "" and vim.api.nvim_get_option_value("buflisted", bo))
      and bt ~= "quickfix"
      and ft ~= "netrw"
    then
      return true
    end

    if not ft or ft == "" then
      return true
    end

    local wo = { scope = "local", win = 0 }
    vim.api.nvim_set_option_value("statuscolumn", stc, wo)
    return true
  end)

  autocmd("BufWinEnter", function(ctx)
    local bo = { buf = ctx.buf }
    local bt = vim.api.nvim_get_option_value("buftype", bo)
    local ft = vim.api.nvim_get_option_value("filetype", bo)
    if
      not (bt == "" and vim.api.nvim_get_option_value("buflisted", bo))
      and bt ~= "quickfix"
      and ft ~= "netrw"
    then
      return
    end

    -- if not ft or ft == "" then
    --   return
    -- end

    local wo = { scope = "local", win = 0 }
    if vim.api.nvim_get_option_value("statuscolumn", wo) == "" then
      vim.api.nvim_set_option_value("statuscolumn", stc, wo)
    end
  end)
end) -- }}}

-- TODO: Move it to after/plugin/statusline.lua
augroup("set_statusline", function(autocmd) -- {{{
  autocmd("UIEnter", function(ctx)
    local bo = { buf = ctx.buf }
    local bt = vim.api.nvim_get_option_value("buftype", bo)
    local ft = vim.api.nvim_get_option_value("filetype", bo)
    if
      not (bt == "" and vim.api.nvim_get_option_value("buflisted", bo))
      or ft == "intro"
    then
      return true
    end

    local stl = vim.api.nvim_get_option_value("statusline", {})
    if
      vim.api.nvim_buf_get_name(bo.buf) ~= ""
      and ft ~= ""
      and (stl == " " or stl == "")
    then
      stl = "%{%v:lua.require'config.option.statusline'()%}"
      vim.api.nvim_set_option_value("statusline", stl, {})
    end

    return true
  end)

  autocmd("BufReadPost", function(ctx)
    local bo = { buf = ctx.buf }
    local bt = vim.api.nvim_get_option_value("buftype", bo)
    local ft = vim.api.nvim_get_option_value("filetype", bo)
    if
      not (bt == "" and vim.api.nvim_get_option_value("buflisted", bo))
      or ft == "intro"
    then
      return
    end

    local wo = { scope = "local", win = 0 }
    local stl = vim.api.nvim_get_option_value("statusline", wo)
    if stl == " " or stl == "" or stl == vim.api.nvim_get_var("intro_stl") then
      stl = "%{%v:lua.require('config.option.statusline')()%}"
      vim.api.nvim_set_option_value("statusline", stl, {})
    end
    return true
  end)
end) -- }}}

augroup("statusline_refresh", function(autocmd) -- {{{
  autocmd({ "DiagnosticChanged", "FileChangedShellPost" }, function()
    vim.schedule(function()
      vim.api.nvim_cmd({ cmd = "redrawstatus", bang = true }, {})
    end)
  end)

  -- autocmd({ "LspRequest", "LspNotify", "LspProgress" }, function()
  autocmd({ "LspProgress" }, function()
    vim.schedule(function()
      vim.api.nvim_cmd({ cmd = "redrawstatus", bang = true }, {})
    end)
  end)
end) -- }}}

-- augroup("file_load_time", function(autocmd) -- {{{
--   autocmd("BufReadPre", function(ctx)
--     vim.b[ctx.buf].loading = vim.uv.hrtime()
--   end)
--
--   autocmd("BufRead", function(ctx)
--     if not vim.b[ctx.buf].loading then
--       return
--     end
--
--     vim.b[ctx.buf].loaded = (vim.uv.hrtime() - vim.b[ctx.buf].loading) / 1e6
--   end)
-- end) -- }}}

-- augroup("lsp_code_action_sign", function(autocmd) -- {{{
--   local ca_ns = vim.api.nvim_create_namespace("codeactionsign")
--   local ca_ext_id
--
--   autocmd("CursorHold", function(args)
--     local buf = args.buf
--     local clients = vim.lsp.get_clients({
--       bufnr = buf,
--       method = "textDocument/codeAction",
--     })
--
--     local function on_res(err, res, ctx)
--       if err or not res or #res < 1 then
--         return
--       end
--
--       local range = ctx.params.range["end"]
--       ca_ext_id = vim.api.nvim_buf_set_extmark(
--         ctx.bufnr,
--         ca_ns,
--         range.line,
--         range.character,
--         { sign_text = "" }
--       )
--     end
--
--     local u = require("vim.lsp.util")
--     for _, c in ipairs(clients) do
--       local param = u.make_range_params(0, c.offset_encoding)
--       param.context = {}
--       c.request("textDocument/codeAction", param, on_res, buf)
--     end
--   end)
--
--   autocmd("CursorMoved", function(args)
--     if not ca_ext_id then
--       return
--     end
--
--     if vim.api.nvim_buf_del_extmark(args.buf, ca_ns, ca_ext_id) then
--       ca_ext_id = nil
--     end
--   end)
-- end) -- }}}

-- augroup("normalize_window_size_in_tmux", function(autocmd) -- {{{
--   autocmd("VimResized", function()
--     if os.getenv("TMUX") then
--       local tabnr = vim.api.nvim_get_current_tabpage()
--       vim.cmd.tabdo("wincmd =")
--       vim.cmd.tabnext(tabnr)
--     end
--   end)
-- end) -- }}}

-- FIXME: Only split when there are quickfix items
-- augroup("split_on_quickfix", function(autocmd) -- {{{
--   autocmd("QuickFixCmdPre", function()
--     vim.api.nvim_cmd({ cmd = "split", mods = { vertical = true } }, {})
--   end)
-- end) -- }}}

-- FIXME: In tiling window manager:
--          - Open neovim, then split
--          - Open new terminal
--          - Close the terminal
--          - Neovim window not redrawn
-- augroup("wrap_on_resized", function(autocmd) -- {{{
--   autocmd({ "VimResized" }, function()
--     local a = vim.api
--     local set, get = a.nvim_set_option_value, a.nvim_get_option_value
--     local winw, winbuf = a.nvim_win_get_width, a.nvim_win_get_buf
--     for _, win in ipairs(a.nvim_list_wins()) do
--       local localbuf = { scope = "local", buf = winbuf(win) }
--       if get("buflisted", localbuf) then
--         local wrap = winw(win) < get("textwidth", localbuf)
--         set("wrap", wrap, { win = win })
--       end
--     end
--   end)
-- end) -- }}}
