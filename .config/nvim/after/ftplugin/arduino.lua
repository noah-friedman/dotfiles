vim.b.spLauncherActionMap = {
  base = "arduino-cli",
  run = "compile -j " .. #vim.uv.cpu_info() .. " -u && arduino-cli monitor --config 115200",
  debug = "debug",
  build = "compile -j" .. #vim.uv.cpu_info(),
}
