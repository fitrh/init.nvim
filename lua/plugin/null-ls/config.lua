local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local action = null_ls.builtins.code_actions
local condition = require("plugin.null-ls.condition")
local plaintext = { "gitcommit", "markdown", "txt" }

null_ls.setup({
  on_attach = require("lsp.attach").with.all,
  sources = {
    -- formatter
    formatting.black.with({
      extra_args = {
        "--line-length",
        vim.api.nvim_buf_get_option(0, "textwidth"),
      },
    }),
    formatting.brittany,
    formatting.fish_indent,
    formatting.isort.with({ extra_args = { "--profile", "black" } }),
    formatting.markdownlint,
    formatting.prettierd.with({ condition = condition.prettier }),
    formatting.shellharden,
    formatting.shfmt.with({ extra_args = { "-i", "4", "-ci" } }),
    formatting.stylua.with({ condition = condition.stylua }),

    -- linter
    diagnostics.cppcheck.with({
      condition = condition.cppcheck,
      extra_args = { "--cppcheck-build-dir=.cppcheck" },
    }),
    diagnostics.eslint_d.with({ condition = condition.eslint }),
    diagnostics.flake8,
    diagnostics.golangci_lint,
    diagnostics.markdownlint,
    diagnostics.misspell.with({ filetypes = plaintext }),
    diagnostics.mypy.with({ condition = condition.mypy }),
    diagnostics.phpcs,
    diagnostics.pylint.with({ condition = condition.pylint }),
    diagnostics.selene.with({ condition = condition.selene }),
    diagnostics.shellcheck,
    diagnostics.write_good.with({ filetypes = plaintext }),

    -- code action
    action.eslint_d.with({ condition = condition.eslint }),
    action.gitrebase,
    action.shellcheck,
  },
})
