return {
	-- 'shaunsingh/nord.nvim',
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	--   -- Example config in lua
	--   vim.g.nord_contrast = true
	--   vim.g.nord_borders = false
	--   vim.g.nord_disable_background = true
	--   vim.g.nord_italic = false
	--   vim.g.nord_uniform_diff_background = true
	--   vim.g.nord_bold = false

	--   -- Load the colorscheme
	--   require('nord').set()

	--   -- Toggle background transparency
	--   local bg_transparent = true

	--   local toggle_transparency = function()
	--     bg_transparent = not bg_transparent
	--     vim.g.nord_disable_background = bg_transparent
	--     vim.cmd [[colorscheme nord]]
	--   end

	--   vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
	-- end,

	-- You can easily change to a different colorscheme.
	-- Change the name of the colorscheme plugin below, and then
	-- change the command in the config to whatever the name of that colorscheme is.
	--
	-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
	-- old theme
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		-- Load the colorscheme here.
		-- Like many other themes, this one has different styles, and you could load
		-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		vim.cmd.colorscheme("tokyonight-night")

		-- You can configure highlights by doing something like:
		vim.cmd.hi("Comment gui=none")
	end,
	opts = {
		transparent = true,
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
	},
}
