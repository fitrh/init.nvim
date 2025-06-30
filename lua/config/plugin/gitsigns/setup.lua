vim.api.nvim_create_autocmd("User", {
  pattern = "GitSignsUpdate",
  group = vim.api.nvim_create_augroup("gitsigns.redrawstatus", {}),
  callback = function()
    vim.schedule(function()
      vim.api.nvim_cmd({ cmd = "redrawstatus", bang = true }, {})
    end)
  end,
})

-- TODO: Set up telescope pickers by utilizing `get_hunks` API

local gitsigns = require("gitsigns")
local sign = require("const.LINE_CHAR")

gitsigns.setup({
  signs_staged = {
    add = { text = sign.THIN.left },
    change = { text = sign.THIN.left },
    delete = { text = sign.THIN.left },
    topdelete = { text = sign.THIN.left },
    changedelete = { text = sign.THIN.left },
  },
  signs = {
    add = { text = sign.THIN.center },
    change = { text = sign.THIN.center },
    delete = { text = sign.THIN.center },
    topdelete = { text = sign.THIN.center },
    changedelete = { text = sign.THIN.center },
    untracked = { text = sign.THIN.center },
  },
  signcolumn = false,
  numhl = true,
  on_attach = function(bufnr)
    require("config.plugin.gitsigns.keymap").attach(gitsigns, bufnr)

    require("sugar.highlight").colorscheme(function(h)
      local base = h.bg("LineNr", { "SignColumn", "FoldColumn", "Normal" })
      local function bg(color, alpha)
        return h.blend(color, base, alpha)
      end

      h.link("GitSignsUntracked", "LineNr")
      for _, kind in ipairs({ "Add", "Change", "Delete", "Untracked" }) do
        local fg = h.fg(("GitSigns%s"):format(kind))
        if kind == "Delete" then
          h.set(("GitSigns%sVirtLn"):format(kind), { bg = bg(fg, 0.1) })
        end
        h.set(("GitSigns%sNr"):format(kind), { fg = fg, bg = bg(fg, 0.10) })
        -- h.set(fmt("GitSignsStaged%sNr", kind), { fg = fg })
        h.set(("GitSigns%sLn"):format(kind), { bg = bg(fg, 0.05) })
        -- h.set(fmt("GitSignsStaged%sLn", kind), { bg = bg(fg, 0.025) })
        if kind ~= "Untracked" then
          h.set(("GitSigns%sInline"):format(kind), { bg = bg(fg, 0.35) })
        end
        if kind ~= "Change" then
          h.set(("GitSigns%sPreview"):format(kind), {
            bg = h.blend(fg, h.bg("NormalFloat"), 0.10),
          })
        end
        -- TODO: add `Staged`
      end
    end)
  end,
  diff_opts = { internal = true, linematch = 60 },
  preview_config = { border = "solid" },
  current_line_blame_opts = {
    delay = vim.api.nvim_get_option_value("updatetime", {}),
  },
  -- TODO: Update icon
  -- TODO: Fix highlight
  current_line_blame_formatter = " ﰖ <abbrev_sha> by <author>, <author_time:%R> - <summary> ",
  trouble = false,
})
