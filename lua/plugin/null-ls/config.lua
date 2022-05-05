local null_ls = require("null-ls")
local f = null_ls.builtins.formatting
local d = null_ls.builtins.diagnostics
local a = null_ls.builtins.code_actions
local c = require("plugin.null-ls.condition")

local js = { "svelte" }
local plaintext = { "gitcommit", "markdown", "txt" }

null_ls.setup({
  on_attach = require("lsp.attach").with.all,
  sources = {
    -- formatter
    f.black.with({
      extra_args = {
        "--line-length",
        vim.api.nvim_buf_get_option(0, "textwidth"),
      },
    }),
    f.brittany,
    f.fish_indent,
    f.isort.with({ extra_args = { "--profile", "black" } }),
    f.markdownlint,
    f.prettierd.with({ condition = c.prettier, extra_filetypes = js }),
    f.shellharden,
    f.shfmt.with({ extra_args = { "-i", "4", "-ci" } }),
    f.stylelint.with({ condition = c.stylelint }),
    f.stylua.with({ condition = c.stylua }),

    -- linter
    d.cppcheck.with({
      condition = c.cppcheck,
      extra_args = { "--cppcheck-build-dir=.cppcheck" },
    }),
    d.eslint_d.with({ condition = c.eslint, extra_filetypes = js }),
    d.fish,
    d.flake8,
    d.golangci_lint,
    d.markdownlint,
    d.misspell.with({ filetypes = plaintext }),
    d.mypy.with({ condition = c.mypy }),
    d.phpcs,
    d.pylint.with({ condition = c.pylint }),
    d.selene.with({ condition = c.selene }),
    d.shellcheck,
    d.stylelint.with({ condition = c.stylelint }),
    d.write_good.with({ filetypes = plaintext }),

    -- code action
    a.eslint_d.with({ condition = c.eslint, extra_filetypes = js }),
    a.gitrebase,
    a.shellcheck,
  },
})
