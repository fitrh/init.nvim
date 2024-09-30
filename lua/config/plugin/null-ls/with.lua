local With = {}
local plaintext = { "gitcommit", "markdown", "txt" }

With.black = {
  extra_args = { "--line-length", vim.bo.textwidth },
}

With.cppcheck = {
  condition = function(u)
    return u.root_has_file({ ".cppcheck" })
  end,
  extra_args = { "--cppcheck-build-dir=.cppcheck" },
}

With.djlint = {
  condition = function(u)
    return u.root_has_file({ ".djlintrc" })
  end,
}

With.eslint_d = {
  condition = function(u)
    return u.root_has_file({
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".eslintrc.json",
    })
  end,
  extra_filetypes = { "svelte" },
}

With.golangci_lint = {
  condition = function(u)
    return u.root_has_file({
      ".golangci.yml",
      ".golangci.yaml",
      ".golangci.toml",
      ".golangci.json",
    })
  end,
}

With.isort = { extra_args = { "--profile", "black" } }
With.ktlint = { timeout = 10000 }
With.misspell = { filetypes = plaintext }

With.mypy = {
  condition = function(u)
    return u.root_has_file({ "mypy.ini", ".mypy.ini" })
  end,
}

With.phpstan = {
  condition = function(u)
    return u.root_has_file({ "phpstan.neon", "phpstan.neon.dist" })
  end,
}

With.pint = {
  condition = function(u)
    return u.root_has_file({ "pint.json" })
  end,
}

With.pylint = {
  condition = function(u)
    return u.root_has_file({ "pylintrc", ".pylintrc" })
  end,
}

With.revive = {
  args = { "-config", "revive.toml", "-formatter", "json", "./..." },
  condition = function(u)
    return u.root_has_file({ "revive.toml" })
  end,
}

With.rustywind = {
  condition = function(u)
    return u.root_has_file({
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.ts",
    })
  end,
}

With.prettierd = {
  condition = function(u)
    return u.root_has_file({
      ".prettierrc",
      ".prettierrc.yml",
      ".prettierrc.json",
    })
  end,
  extra_filetypes = { "svelte" },
}

With.selene = {
  condition = function(u)
    return u.root_has_file({ "selene.toml" })
  end,
}

With.shfmt = { extra_args = { "-ci" } }

With.staticcheck = {
  condition = function(u)
    return u.root_has_file({ "staticcheck.conf" })
  end,
}

With.stylelint = {
  condition = function(u)
    return u.root_has_file({
      ".stylelintrc",
      ".stylelintrc.json",
      ".stylelintrc.yml",
      ".stylelintrc.js",
      "stylelint.config.js",
      "stylelint.config.cjs",
    })
  end,
}

With.stylua = {
  condition = function(u)
    return u.root_has_file({ "stylua.toml", ".stylua.toml" })
  end,
}

With.write_good = { filetypes = plaintext }

With.yamlfmt = {
  condition = function(u)
    return u.root_has_file({ ".yamlfmt" })
  end,
}

return With
