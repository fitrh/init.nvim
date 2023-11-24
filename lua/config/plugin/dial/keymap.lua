local nmap, xmap = {}, {}

nmap["<C-a>"] = function()
  require("dial.map").manipulate("increment", "normal")
end
nmap["<C-x>"] = function()
  require("dial.map").manipulate("decrement", "normal")
end
nmap["g<C-a>"] = function()
  require("dial.map").manipulate("increment", "gnormal")
end
nmap["g<C-x>"] = function()
  require("dial.map").manipulate("decrement", "gnormal")
end

xmap["<C-a>"] = function()
  require("dial.map").manipulate("increment", "visual")
end
xmap["<C-x>"] = function()
  require("dial.map").manipulate("decrement", "visual")
end
xmap["g<C-a>"] = function()
  require("dial.map").manipulate("increment", "gvisual")
end
xmap["g<C-x>"] = function()
  require("dial.map").manipulate("decrement", "gvisual")
end

local map = vim.api.nvim_set_keymap

for key, fn in pairs(nmap) do
  map("n", key, "", {
    callback = fn,
    silent = true,
    noremap = true,
  })
end

for key, fn in pairs(xmap) do
  map("x", key, "", {
    callback = fn,
    silent = true,
    noremap = true,
  })
end
