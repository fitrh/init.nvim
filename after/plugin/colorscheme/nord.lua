local function override()
  local api = vim.api

  ---@param c number|string 24-bit RGB value or color name
  ---@return string "#rrggbb"
  local function hex(c)
    if type(c) ~= "string" then
      return string.format("%06X", c)
    end

    local named_color = vim.api.nvim_get_color_by_name(c)
    if named_color ~= -1 then
      c = named_color
    end

    return string.format("%06X", c)
  end

  ---@param c string "#rrggbb" color format
  ---@return { r: number, g: number, b: number }
  local function rgb(c)
    local rrggbb = string.gsub(c, "#", "")
    local r = rrggbb:sub(1, 2)
    local g = rrggbb:sub(3, 4)
    local b = rrggbb:sub(5, 6)
    return { r = tonumber(r, 16), g = tonumber(g, 16), b = tonumber(b, 16) }
  end

  local function blend(top, bottom, alpha)
    local a = alpha > 1 and (alpha / 100) or alpha
    local b = rgb(bottom)
    local t = rgb(top)

    local function channel(c)
      c = (a * t[c] + ((1 - a) * b[c]))
      return math.floor(math.min(math.max(0, c), 255) + 0.5)
    end

    return ("#%02X%02X%02X"):format(channel("r"), channel("g"), channel("b"))
  end

  local light = api.nvim_get_option_value("background", {}) == "light"
  local color = vim.api.nvim_call_function("NordPalette", {})
  --  {
  --   nord0 = "#2E3440",
  --   nord1 = "#3B4252",
  --   nord2 = "#434C5E",
  --   nord3 = "#4C566A",
  --   nord3_bright = "#616E88",
  --   nord4 = "#D8DEE9",
  --   nord5 = "#E5E9F0",
  --   nord6 = "#ECEFF4",
  --   nord7 = "#8FBCBB",
  --   nord8 = "#88C0D0",
  --   nord9 = "#81A1C1"
  --   nord10 = "#5E81AC",
  --   nord11 = "#BF616A",
  --   nord12 = "#D08770",
  --   nord13 = "#EBCB8B",
  --   nord14 = "#A3BE8C",
  --   nord15 = "#B48EAD",
  -- }

  local get_hl = api.nvim_get_hl
  local function get(group)
    return get_hl(0, { name = group, link = false })
  end
  local Normal = get("Normal")
  local function nblend(top, alpha)
    return blend(hex(top), hex(Normal.bg), alpha)
  end

  local set_hl = api.nvim_set_hl
  local function hi(group, def)
    set_hl(0, group, def)
  end

  hi("NormalFloat", { fg = color.nord4, bg = color.nord2 })
  hi("TelescopeNormal", { link = "NormalFloat" })
  hi("TelescopeBorder", { fg = color.nord2, bg = color.nord2 })
  hi("TelescopeTitle", { link = "PmenuSel" })
  hi("TelescopeSelection", { link = "PmenuSel" })
  hi("CmpCursorLine", { link = "PmenuSel" })
end

local group = vim.api.nvim_create_augroup("override_nord_colorscheme", {})
local au = vim.api.nvim_create_autocmd

au("ColorScheme", {
  group = group,
  pattern = "nord",
  callback = function()
    override()
    -- vim.api.nvim_create_autocmd("OptionSet", {
    --   group = group,
    --   pattern = "background",
    --   callback = function()
    --     if vim.g.colors_name and vim.g.colors_name ~= "nord" then
    --       return true
    --     end
    --
    --     override()
    --   end,
    -- })
  end,
})

au("User", {
  group = group,
  pattern = "NordPre",
  callback = function()
    vim.cmd.highlight("clear")
    -- vim.cmd.colorscheme("vim")
    vim.cmd.colorscheme("nord")
  end,
})
