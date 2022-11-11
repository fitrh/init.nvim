local gitsigns = require("gitsigns")
local sign = require("const.LINE_CHAR")

gitsigns.setup({
  signs = {
    add = { text = sign.HALF.right },
    change = { text = sign.HALF.right },
    delete = { text = sign.HALF.right },
    topdelete = { text = sign.HALF.right },
    changedelete = { text = sign.HALF.right },
  },
  signcolumn = false,
  numhl = true,
  on_attach = function(bufnr)
    require("config.plugin.gitsigns.keymap").attach(gitsigns, bufnr)

    require("sugar.highlight").colorscheme(function(h)
      local base = h.bg("LineNr", { "Normal", "SignColumn", "NormalFloat" })

      for _, kind in ipairs({ "Add", "Change", "Delete" }) do
        local inherit = ("GitSigns%s"):format(kind)
        h.set(("GitSigns%sNr"):format(kind), {
          inherit = inherit,
          bg = h.blend(h.fg(inherit), base, 0.10),
        })
        h.set(("GitSigns%sLn"):format(kind), {
          bg = h.blend(h.fg(inherit), base, 0.05),
        })
        h.set(("GitSigns%sInline"):format(kind), {
          bg = h.blend(h.fg(inherit), base, 0.35),
        })
        if kind ~= "Change" then
          h.set(("GitSigns%sPreview"):format(kind), {
            bg = h.blend(h.fg(inherit), base, 0.10),
          })
        end
      end
    end)
  end,
  preview_config = { border = "rounded", focusable = false },
  current_line_blame_opts = { delay = vim.api.nvim_get_option("updatetime") },
  current_line_blame_formatter = " ﰖ <abbrev_sha> by <author>, <author_time:%R> - <summary>",
})
