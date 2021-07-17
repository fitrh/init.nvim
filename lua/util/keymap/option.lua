local Option = {}

function Option:new()
  local instance = {
    _noremap = false,
    _silent = false,
    _expr = false,
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function Option:noremap()
  self._noremap = true
  return self
end

function Option:silent()
  self._silent = true
  return self
end

function Option:expr()
  self._expr = true
  return self
end

function Option:get()
  local opt = {
    noremap = self._noremap,
    silent = self._silent,
    expr = self._expr,
  }
  return opt
end

return Option
