local Condition = {}

function Condition.cppcheck(util)
  return util.root_has_file({ ".cppcheck" })
end

function Condition.djlint(util)
  return util.root_has_file({ ".djlintrc" })
end

function Condition.eslint(util)
  local rc = {
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
  }
  return util.root_has_file(rc)
end

function Condition.golangci(util)
  local rc = {
    ".golangci.yml",
    ".golangci.yaml",
    ".golangci.toml",
    ".golangci.json",
  }
  return util.root_has_file(rc)
end

function Condition.mypy(util)
  return util.root_has_file({ "mypy.ini", ".mypy.ini" })
end

function Condition.phpstan(util)
  return util.root_has_file({ "phpstan.neon", "phpstan.neon.dist" })
end

function Condition.prettier(util)
  local rc = { ".prettierrc", ".prettierrc.yml", ".prettierrc.json" }
  return util.root_has_file(rc)
end

function Condition.pylint(util)
  return util.root_has_file({ "pylintrc", ".pylintrc" })
end

function Condition.revive(util)
  return util.root_has_file({ "revive.toml" })
end

function Condition.selene(util)
  return util.root_has_file({ "selene.toml" })
end

function Condition.staticcheck(util)
  return util.root_has_file({ "staticcheck.conf" })
end

function Condition.stylelint(util)
  return util.root_has_file({
    ".stylelintrc",
    ".stylelintrc.json",
    ".stylelintrc.yml",
    ".stylelintrc.js",
    "stylelint.config.js",
    "stylelint.config.cjs",
  })
end

function Condition.stylua(util)
  return util.root_has_file({ "stylua.toml", ".stylua.toml" })
end

return Condition
