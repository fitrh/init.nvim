local Map = {}

function Map:new()
  local instance = {
    _bufnr = nil,
    _key = nil,
    _mode = "",
    _command = nil,
    _options = {},
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function Map:exec(command)
  if not self._command then
    self._command = ("<Cmd>%s<CR>"):format(command)
  end
  return self
end

function Map:plug(command)
  if not self._command then
    self._command = ("<Plug>%s"):format(command)
  end
  return self
end

function Map:run(command)
  if not self._command then
    self._command = command
  end
  return self
end

function Map:lua(command)
  if not self._command then
    self._command = ("<Cmd>lua %s<CR>"):format(command)
  end
  return self
end

function Map:on_press(key, in_mode, bufnr)
  self._key = key
  self._mode = in_mode or ""
  self._bufnr = bufnr or nil
  return self
end

function Map:disable()
  self._command = "<Nop>"
  return self
end

function Map:with(opt)
  self._options = opt:get()
  return self
end

return Map
