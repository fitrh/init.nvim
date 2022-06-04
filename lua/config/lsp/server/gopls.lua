local bin = "gopls"

return require("config.lsp.server").with(bin, {
  cmd = { bin, "serve" },
  settings = {
    gopls = {
      gofumpt = true, -- A stricter gofmt
      codelenses = {
        -- SEE: https://github.com/golang/tools/blob/master/gopls/doc/settings.md#code-lenses
        gc_details = true, -- Toggle the calculation of gc annotations
        generate = true, -- Runs go generate for a given directory
        regenerate_cgo = true, -- Regenerates cgo definitions
        test = true, -- Runs go test for a specific set of test or benchmark functions
        tidy = true, -- Runs go mod tidy for a module
        upgrade_dependency = true, -- Upgrades a dependency in the go.mod file for a module
        vendor = true, -- Runs go mod vendor for a module
      },
      usePlaceholders = true, -- enables placeholders for function parameters or struct fields in completion responses
      analyses = {
        -- SEE: https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
        fieldalignment = true, -- find structs that would use less memory if their fields were sorted
        nilness = true, -- check for redundant or impossible nil comparisons
        shadow = true, -- check for possible unintended shadowing of variables
        unusedparams = true, -- check for unused parameters of functions
        unusedwrite = true, -- checks for unused writes, an instances of writes to struct fields and arrays that are never read
        useany = true, -- check for constraints that could be simplified to "any"
      },
    },
  },
})
