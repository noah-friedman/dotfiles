{ ... }: {
  extension = rec {
    cpp = {
      __raw = ''function(path, _)
        if vim.fs.root(path, function(name) return name:match "%.ino$" ~= nil end) then
          return "arduino"
        else
          return "cpp"
        end
      end'';
    };
    hpp = cpp;
    h = cpp;
  };
}
