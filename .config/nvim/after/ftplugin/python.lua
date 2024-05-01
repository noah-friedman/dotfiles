vim.b.spLauncherActionMap = {
  base = "python3",
  run = "%",
  debug = {
    handler = "-m pdb %",
    config = {
      window = {
        focus = "insert",
        persist = false,
      }
    }
  },
  test = "-m unittest %",
}

vim.schedule_wrap(require "venv-selector".retrieve_from_cache)()
