return {
	-- Theme (catppuccin)
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"sainnhe/gruvbox-material",
		name = "gruvbox-material",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
}
