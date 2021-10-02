local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.config({
  sources = {
    formatting.black,
    formatting.fish_indent,
    formatting.isort,
    formatting.markdownlint,
    formatting.prettierd.with({
      condition = function(utils)
        local has = utils.root_has_file
        return has(".prettierrc")
          or has(".prettierrc.yml")
          or has(".prettierrc.json")
      end,
    }),
    formatting.shfmt.with({ extra_args = { "-i", "4", "-ci" } }),
    formatting.stylua.with({
      condition = function(utils)
        return utils.root_has_file("stylua.toml")
          or utils.root_has_file(".stylua.toml")
      end,
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
    diagnostics.markdownlint,
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
  },
})

require("lspconfig")["null-ls"].setup({
  capabilities = require("lsp.capability"),
  handlers = require("lsp.handler").default(),
  on_attach = require("lsp.attach").with_all_extensions,
})
