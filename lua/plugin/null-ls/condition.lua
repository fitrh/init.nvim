local Condition = {}

function Condition.cppcheck(util)
  return util.root_has_file({ ".cppcheck" })
end

function Condition.eslint(util)
  local rc = { ".eslintrc.js", ".eslintrc.yml", ".eslintrc.json" }
  return util.root_has_file(rc)
end

function Condition.mypy(util)
  return util.root_has_file({ "mypy.ini", ".mypy.ini" })
end

function Condition.prettier(util)
  local rc = { ".prettierrc", ".prettierrc.yml", ".prettierrc.json" }
  return util.root_has_file(rc)
end

function Condition.pylint(util)
  return util.root_has_file({ "pylintrc", ".pylintrc" })
end

function Condition.selene(util)
  return util.root_has_file({ "selene.toml" })
end

function Condition.stylua(util)
  return util.root_has_file({ "stylua.toml", ".stylua.toml" })
end

return Condition
