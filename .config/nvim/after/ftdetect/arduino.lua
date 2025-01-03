---@param c string
local function checker(c)
  return function(path, bufnr)
    if vim.fs.root(path, function(name) return name:match "%.ino$" ~= nil end) then
      return "arduino"
    else
      return c
    end
  end
end

vim.filetype.add {
  extension = {
    cpp = checker "cpp",
    hpp = checker "cpp",
    h = checker "c",
  }
}
