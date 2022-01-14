local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local action = null_ls.builtins.code_actions

null_ls.setup({
  on_attach = require("lsp.attach").with.all,
  sources = {
    formatting.black,
    formatting.brittany,
    formatting.fish_indent,
    formatting.isort.with({ extra_args = { "--profile", "black" } }),
    formatting.markdownlint,
    formatting.prettierd.with({
      condition = function(utils)
        local has = utils.root_has_file
        return has(".prettierrc")
          or has(".prettierrc.yml")
          or has(".prettierrc.json")
      end,
    }),
    formatting.shellharden,
    formatting.shfmt.with({ extra_args = { "-i", "4", "-ci" } }),
    formatting.stylua.with({
      condition = function(utils)
        return utils.root_has_file("stylua.toml")
          or utils.root_has_file(".stylua.toml")
      end,
    }),

    diagnostics.cppcheck.with({
      condition = function(utils)
        return utils.root_has_file(".cppcheck")
      end,
      extra_args = { "--cppcheck-build-dir=.cppcheck" },
    }),
    diagnostics.eslint_d.with({
      condition = function(utils)
        local has = utils.root_has_file
        return has(".eslintrc.js")
          or has(".eslintrc.yml")
          or has(".eslintrc.json")
      end,
    }),
    diagnostics.flake8.with({ diagnostics_format = "[#{c}] #{m}" }),
    diagnostics.golangci_lint,
    diagnostics.markdownlint,
    diagnostics.misspell.with({
      filetypes = { "gitcommit", "markdown", "txt" },
    }),
    diagnostics.mypy.with({ diagnostics_format = "[#{c}] #{m}" }),
    diagnostics.phpcs,
    diagnostics.pylint.with({
      diagnostics_format = "[#{c}] #{m}",
      condition = function(utils)
        local has = utils.root_has_file
        return has("pylintrc") or has(".pylintrc")
      end,
    }),
    diagnostics.selene.with({
      condition = function(utils)
        return utils.root_has_file("selene.toml")
      end,
    }),
    diagnostics.shellcheck.with({ diagnostics_format = "[#{c}] #{m}" }),
    diagnostics.write_good.with({ filetypes = { "markdown", "gitcommit" } }),

    action.gitsigns.with({
      condition = function(utils)
        return utils.root_has_file(".git")
      end,
    }),
    action.gitrebase,
    action.shellcheck,
  },
})
