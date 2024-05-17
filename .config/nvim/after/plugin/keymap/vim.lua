-- Keymaps for switching buffers/windows/tabpages
for mod, cmd in pairs {
  S = "b",
  A = { "wincmd ", "W", "w" },
  ["S-A"] = "tab"
} do
  for dir, key in pairs {
    [cmd[2] or "p"] = "Left",
    [cmd[3] or "n"] = "Right",
  } do
    key = "<" .. mod .. "-" .. key .. ">"
    vim.keymap.set("n", key, "<Cmd>" .. (cmd[1] or cmd) .. dir .. "<CR>")
  end
end

-- <CR> opens folds, <S-BS> closes them
vim.keymap.set("n", "<CR>", function()
                 if vim.fn.foldclosed --[[@as function]] "." ~= -1 then
                   vim.cmd.foldopen()
                 else
                   vim.api.nvim_feedkeys(
                     vim.api.nvim_replace_termcodes("<CR>", true, true, true),
                     "n", false)
                 end
               end, { noremap = true })
vim.keymap.set("n", "<S-BS>", function()
  if vim.fn.foldlevel --[[@as fun(lnum: integer | "."): integer]] "." ~= 0 then
    vim.cmd.foldclose()
  else
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<S-BS>", true, true, true),
      "n", false)
  end
end)

-- 'E' opens all folds, 'C' closes all folds
for lhs, rhs in pairs {
  E = "R",
  C = "M"
} do
  vim.keymap.set("n", lhs, "z" .. rhs, { noremap = true })
end

local maps = {
  -- Tab navigation
  ["<D-t>"] = function() vim.cmd "$tabnew" end,
  ["<D-b>"] = vim.cmd.enew,
  ["<D-w>"] = vim.cmd.tabclose,
  ["<D-W>"] = vim.cmd.tabonly,
  ["<D-Left>"] = vim.cmd.tabprevious,
  ["<D-Right>"] = vim.cmd.tabnext,
  ["<D-S-Left>"] = function() vim.cmd "-tabmove" end,
  ["<D-S-Right>"] = function() vim.cmd "+tabmove" end,

  -- Terminal
  ["<D-T>"] = function()
    vim.cmd "$tabnew +terminal"
  end,
}

for i = 1, 9 do
  maps["<D-" .. i .. ">"] = function() vim.cmd.tabn(i) end
end

for lhs, rhs in pairs(maps) do
  vim.keymap.set({ "n", "i", "v", "t" }, lhs, rhs, { noremap = true })
end

-- Fast scrolling with 'alt'/'meta' key
for letter, arrow in pairs {
  b = "Left",
  w = "Right",
} do
  vim.keymap.set({ "n", "i", "t", "c" }, "<M-" .. arrow .. ">", "<Cmd>normal " .. letter .. "<CR>")
  vim.keymap.set({ "n", "i", "t", "c" }, "<M-S-" .. arrow .. ">", "<Cmd>normal " .. letter:upper() .. "<CR>")
end
