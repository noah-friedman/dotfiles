require "spLauncher.util".workspace("mdx_analyzer", function(root_dir)
  if vim.fn.filereadable(root_dir .. "/bun.lockb") ~= 0 then
    return {
      base = "bun run",
      run = "start",
      debug = true,
      test = true,
      build = true,
    }
  elseif vim.fn.filereadable(root_dir .. "/package-lock.json") ~= 0 then
    return {
      base = "npm run",
      run = "start",
      debug = true,
      test = true,
      build = true,
    }
  end
  return {}
end)

require "otter".activate { "typescriptreact" }
