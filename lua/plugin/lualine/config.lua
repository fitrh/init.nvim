local line = require("lualine")
local colors = require("util.palette")
local lsp = require("plugin.lualine.component.lsp").setup({ fg = colors.blue2 })
local gitsigns = require("plugin.lualine.component.gitsigns")

local options = {
  theme = "tokyonight",
  component_separators = { "", "" },
  section_separators = { "", "" },
  disabled_filetypes = { "Outline" },
}

-- TODO: add mode module

local diagnostics = {
  "diagnostics",
  sources = { "nvim_lsp" },
}

local fileicon = {
  "filetype",
  format = function() return " " end,
  right_padding = 0,
}

local filename = {
  "filename",
  left_padding = 0,
  color = { gui = "BOLD", },
  path = 1, -- relative path
  file_status = false,
}

local modified = {
  function() return vim.bo.modified and "" or nil end, -- "ﴖ"
  color = { fg = colors.red_br_2 }, -- colors.blue5
  left_padding = 0,
}

local readonly = {
  function()
    if not vim.bo.readonly or not vim.bo.modifiable then
      return nil
    end
    return "" -- ""
  end,
  color = { fg = colors.red1 },
}

local blank = {
  function() return " " end,
  padding = 0,
}

local diff = {
  "diff",
  -- foreground color
  color_added = colors.gitsigns.add, -- colors.teal
  color_modified = colors.gitsigns.change, -- colors.cyan
  color_removed = colors.gitsigns.delete, -- colors.red
  symbols = {
    added = " ",
    modified = " ",
    removed = " "
  },
}

local branch = {
  "branch",
  icon = "",
  color = { fg = colors.purple, gui = "BOLD" },
}

local location = {
  function()
    local len = #tostring(vim.fn.line("$"))
    return ("%%%sl,%%3c"):format(len)
  end,
  icon = "ﰙ",
}

local lines = {
  function() return tostring(vim.fn.line("$")) end,
  icon = "", -- the above function must return string to make icon work
  color = { fg = colors.blue },
  left_padding = 0,
}

local sections = {
  lualine_a = { blank },
  lualine_b = {},
  lualine_c = { blank, readonly, fileicon, filename, modified, diagnostics, },
  lualine_x = { gitsigns, branch, lsp.status, location, lines },
  lualine_y = {},
  lualine_z = { blank }
}

line.setup({
  options = options,
  sections = sections,
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
})
