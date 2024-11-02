vim.filetype.add {
  extension = {
    hpp = function(path, bufnr)
      if vim.fs.root(path, function(name) return name:match "%.ino$" ~= nil end) then
        return "arduino"
      else
        return "cpp"
      end
    end
  }
}
