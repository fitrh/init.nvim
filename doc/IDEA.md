# IDEA

## PLUGIN MANAGER

## PLUGIN SPEC

```lua
---@class Spec
---@field source string|string[]
---@field setup? fun(ctx: SpecCtx)
---@field loader? SpecLoader
---@field deps? Spec[]
---...
```

```lua
---@param spec Spec
function walk_spec(spec)
    local deps = vim.iter(spec.deps):next()
    if deps then
        walk_spec(deps)
    end
    ...
end
```
