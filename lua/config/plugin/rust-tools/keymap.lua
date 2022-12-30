local M = {}

function M.attach(bufnr)
  local keymap = require("sugar.keymap")
  local map, n, v = keymap.map, keymap.mode.normal, keymap.mode.visual

  keymap.bind({
    n(map("[rw", function()
      require("rust-tools.workspace_refresh").reload_workspace()
    end)),
    n(map("[rr", function()
      require("rust-tools.inlay_hints").toggle_inlay_hints()
    end)),
    n(map("[rR", function()
      require("rust-tools.runnables").runnables()
    end)),
    n(map("[rE", function()
      require("rust-tools.expand_macro").expand_macro()
    end)),
    n(map("[rc", function()
      require("rust-tools.open_cargo_toml").open_cargo_toml()
    end)),
    n(map("[rP", function()
      require("rust-tools.parent_module").parent_module()
    end)),
    n(map("[rJ", function()
      require("rust-tools.join_lines").join_lines()
    end)),
    n(map("[ra", function()
      require("rust-tools.hover_actions").hover_actions()
    end)),
    v(map("[ra", function()
      require("rust-tools.hover_range").hover_range()
    end)),
    n(map("[rj", function()
      require("rust-tools.move_item").move_item()
    end)),
    n(map("[rk", function()
      require("rust-tools.move_item").move_item(true)
    end)),
  }, { buffer = bufnr })
end

return M
