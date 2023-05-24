local local_exists = require'dotfiles.local_exists'

-- Run local `pre` config (if present)
if local_exists('pre') then
	require'local.pre'
end

-- Editor settings (`:set` commands)
for scope, object in pairs({
	g = {
		autowrite	= true,																-- automatically save before commands like :next and :make
		guicursor	= vim.go.guicursor .. ",i:-blinkwait175-blinkoff150-blinkon175",	-- make the cursor blink in insert mode
		showmode	= false,															-- don't show mode (e.g. -- INSERT --) because it's shown by Lualine
		splitbelow	= true, 															-- put new (horizontally split) windows below current
		splitright	= true,																-- put new (vertically split) windows to the right
	},
	w = {
		number 		= true,																-- show line numbers
	},
}) do
for option, value in pairs(object) do
	-- add the 'o' because thats what the fields are *actually* called (e.g. 'wo', 'bo')
	-- see ':help vim.o'
	vim[scope..'o'][option] = value
end
end

-- Set tab size based on filetype
require'dotfiles.tabsize'

-- Keymaps for switching buffers
vim.api.nvim_set_keymap('n', '<', ':bp<CR><C-l>', {noremap = true})
vim.api.nvim_set_keymap('n', '>', ':bn<CR><C-l>', {noremap = true})

-- Configure plugin manager
require'dotfiles.setup.lazy'

-- Run local `post` config (if present)
if local_exists('post') then
	require'local.post'
end
